#!/bin/bash

sudo /etc/init.d/fe start
sudo /etc/init.d/xcp-networkd start
sudo /etc/init.d/genptoken start
sudo /etc/init.d/squeezed start
sudo /etc/init.d/xcp-rrdd start
sudo /etc/init.d/xenopsd start
sudo /etc/init.d/xapi start

sleep 30

/etc/init.d/xcp-rrdd-plugins start
/etc/init.d/firstboot start
/etc/init.d/perfmon start

. /etc/xensource-inventory
xe pif-scan host-uuid=${INSTALLATION_UUID}
PIF=$(xe pif-list device=eth0 params=uuid --minimal)
xe pif-reconfigure-ip uuid=${PIF} mode=dhcp
xe pif-plug uuid=${PIF}

