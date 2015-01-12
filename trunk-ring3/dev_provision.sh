#!/bin/bash

rpm -ivh http://mirror.ancl.hawaii.edu/linux/epel/6/i386/epel-release-6-8.noarch.rpm

cat > /etc/yum.repos.d/ring3.repo << EOF
[ring3]
name=ring3
enabled=1
baseurl=http://www.uk.xensource.com/yum-trunk-ring3
gpgcheck=0
EOF
echo I am provisioning...

yum clean all

yum update -y

yum install -y \
    ocaml-text-devel \
    ocaml-ocplib-endian-debuginfo \
    ocamlify \
    ocaml-qmp-debuginfo \
    ocaml-netdev-devel \
    ocaml-xcp-inventory \
    ocaml-nbd-devel \
    ocaml-xen-lowlevel-libs-devel \
    ocaml-xcp-idl-debuginfo \
    ocaml-xenstore-clients-devel \
    ocaml-camlp4-devel \
    ocaml-ounit-devel \
    ocaml-xmlm-devel \
    ocaml-xen-api-client-devel \
    ocaml-mirage-types-devel \
    ocaml-camldm-devel \
    ocaml-uutf-debuginfo \
    ocaml-io-page \
    ocaml-crc \
    ocaml-tar-devel \
    ocaml-cstruct \
    ocaml-camldm-debuginfo \
    ocamlmod \
    ocaml-xen-lowlevel-libs \
    ocaml-cstruct-debuginfo \
    ocaml-type-conv-debuginfo \
    ocaml-xen-api-libs-transitional-debuginfo \
    ocaml-obuild \
    ocaml-tar-debuginfo \
    ocaml \
    ocaml-qmp-devel \
    ocaml-getopt-debuginfo \
    ocaml-react \
    ocaml-re \
    ocaml-getopt-devel \
    ocaml-nbd-debuginfo \
    ocaml-getopt \
    ocaml-re-debuginfo \
    ocaml-ssl-devel \
    ocaml-yojson-debuginfo \
    ocaml-type-conv \
    ocamlmod-debuginfo \
    ocaml-fileutils \
    ocaml-odn-devel \
    ocaml-uri-debuginfo \
    ocaml-xcp-inventory-debuginfo \
    ocaml-bitstring-devel \
    ocaml-uuidm-debuginfo \
    ocaml-xen-api-client-debuginfo \
    ocaml-ssl-debuginfo \
    ocaml-libvhd-devel \
    ocaml-cdrom-devel \
    ocaml-source \
    ocaml-rrd-transport-devel \
    ocaml-camlp4 \
    ocaml-react-devel \
    ocaml-xenops-debuginfo \
    ocaml-findlib \
    ocaml-cstruct-devel \
    ocaml-docs \
    ocaml-xmlm-debuginfo \
    ocaml-cohttp-debuginfo \
    ocaml-xcp-inventory-devel \
    ocaml-fileutils-devel \
    ocaml-xcp-rrd-devel \
    ocaml-debuginfo \
    ocaml-fd-send-recv-devel \
    ocaml-vhd \
    ocaml-cohttp-devel \
    ocaml-xcp-idl-devel \
    ocaml-odn \
    ocaml-stdext-devel \
    ocaml-odn-debuginfo \
    ocaml-io-page-devel \
    ocaml-netdev-debuginfo \
    ocaml-camlzip \
    ocaml-sexplib \
    xen-ocaml-libs \
    ocaml-xen-lowlevel-libs-debuginfo \
    ocaml-xen-api-libs-transitional-devel \
    ocaml-stdext-debuginfo \
    ocaml-sexplib-debuginfo \
    ocaml-ounit \
    ocaml-findlib-devel \
    ocaml-sha-debuginfo \
    ocaml-xenstore-clients-debuginfo \
    ocaml-uri-devel \
    ocaml-camlzip-devel \
    ocaml-compiler-libs \
    ocaml-bitstring \
    ocaml-ocamldoc \
    ocaml-libvhd-debuginfo \
    ocaml-camlzip-debuginfo \
    ocaml-rpc-debuginfo \
    ocaml-oclock-devel \
    ocaml-xcp-rrd-debuginfo \
    ocaml-opasswd-devel \
    ocaml-xmlm \
    ocaml-vhd-devel \
    ocaml-obuild-debuginfo \
    ocaml-ctypes-debuginfo \
    ocaml-mlvm-debuginfo \
    ocaml-sha-devel \
    ocaml-uuidm-devel \
    ocaml-re-devel \
    ocaml-lwt-devel \
    ocamlify-debuginfo \
    xen-ocaml-devel \
    ocaml-xenops-devel \
    ocaml-rpc-devel \
    ocaml-cdrom-debuginfo \
    ocaml-uutf-devel \
    ocaml-rrd-transport \
    ocaml-fd-send-recv-debuginfo \
    ocaml-xenstore-devel \
    ocaml-ocplib-endian-devel \
    ocaml-tapctl-debuginfo \
    ocaml-ctypes-devel \
    ocaml-uutf \
    ocaml-opasswd-debuginfo \
    ocaml-xenstore-debuginfo \
    ocaml-crc-devel \
    ocaml-mlvm-devel \
    ocaml-tapctl-devel \
    ocaml-mirage-types \
    ocaml-runtime \
    ocaml-yojson-devel \
    ocaml-ctypes \
    omake \
    git \
    mercurial \
    pam-devel \
    libffi-devel \
    ocaml-cmdliner \
    ocaml-cmdliner-devel \
    ocaml-stringext-devel \
    ocaml-gnt-devel \
    ocaml-rrdd-plugin-devel \
    opam \

