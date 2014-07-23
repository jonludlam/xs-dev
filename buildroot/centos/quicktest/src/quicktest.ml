

open Cmdliner

module Xs = Xs_client_lwt.Client(Xs_transport_lwt_unix_client)
module V = struct
  include Vchan.Make(Unix_activations)(Xs)
  type 'a io = 'a Lwt.t
  type buffer = Cstruct.t
  type flow = t
end
module Vchan_http = Vchan_http.Make(V)
module RpcM = Vchan_http.RpcM
module Client = Test_interface.ClientM(RpcM)
module X = Xen_api_lwt_unix

let (|>) x y = y x

let evtchn_h = Eventchn.init ()

let rpc =
  let uri = "file:///var/lib/xcp/xapi" in
  X.make uri

let get_other_install_media rpc session =
  lwt vms = X.VM.get_all_records rpc session in
  List.find (fun (_ref, _rec) -> _rec.API.vM_name_label = "Other install media") vms |> fst |> Lwt.return

let wait rpc session_id timeout classes pred =
  let rec inner token left =
    let start = Unix.gettimeofday () in
    lwt events = X.Event.from ~rpc ~session_id ~classes ~token ~timeout:left in
    let end' = Unix.gettimeofday () in
    let left = left -. (end' -. start) in
    let ef = Event_types.event_from_of_rpc events in 
    let success = List.exists (fun ev -> 
      pred (Event_helper.record_of_event ev)) ef.Event_types.events 
    in
    if (not success) && (left > 0.0)
    then inner ef.Event_types.token left
    else Lwt.return success
  in inner "" timeout

let create_vm rpc session_id name =
  lwt template = get_other_install_media rpc session_id in
  lwt clone = X.VM.clone ~rpc ~session_id ~vm:template ~new_name:name in
  lwt () = X.VM.set_PV_kernel ~rpc ~session_id ~self:clone ~value:"/boot/guest/mirage-testvm.xen" in
  let mem = Int64.(mul 64L (mul 1024L 1024L)) in
  lwt () = X.VM.set_memory_limits ~rpc ~session_id ~self:clone ~static_max:mem ~static_min:mem ~dynamic_max:mem ~dynamic_min:mem in
  lwt () = X.VM.set_HVM_boot_policy ~rpc ~session_id ~self:clone ~value:"" in
  lwt () = X.VM.provision ~rpc ~session_id ~vm:clone in
  lwt () = X.VM.set_actions_after_crash ~rpc ~session_id ~self:clone ~value:`preserve in
  Printf.printf "Created VM: %s" clone;
  Lwt.return clone

let test1 rpc session_id =
  lwt vm = create_vm rpc session_id "mirage" in
  lwt () = X.VM.start ~rpc ~session_id ~vm ~start_paused:false ~force:false in
  lwt domid' = X.VM.get_domid ~rpc ~session_id ~self:vm in
  let domid = Int64.to_int domid' in
  lwt flow = V.client ~evtchn_h ~domid ~xs_path:(Printf.sprintf "/local/domain/%d/data/vchan" domid) in
  RpcM.vch := Some (Vchan_http.openflow flow);
  lwt () = Client.shutdown () in
  V.close flow;
  lwt success = wait rpc session_id 30.0 [Printf.sprintf "vm/%s" vm] (function 
  | Event_helper.VM (_,Some r) ->
    r.API.vM_power_state = `Halted
  | _ -> false) in
  assert(success);
  Lwt.return ()

let _ = 
  Lwt_main.run (
    lwt session_id = X.Session.login_with_password ~rpc ~uname:"" ~pwd:"" ~version:"" in
    test1 rpc session_id)

