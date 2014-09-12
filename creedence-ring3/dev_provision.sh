#!/bin/bash

sudo yum clean all
sudo rpm -Uvh http://dl.fedoraproject.org/pub/epel/5/i386/epel-release-5-4.noarch.rpm
sudo yum clean all
sudo yum update -y
sudo yum install -y git-core pkg-config libX11 libX11-devel e4fsprogs-libs libaio libaio-devel gdbm-devel tetex-latest pam-devel
sudo yum groupinstall "Development Tools" -y

sudo mkdir -p /misc/cache
sudo mount camos.uk.xensource.com:/vol/cache/cache /misc/cache

for i in ocaml xen blktap api-libs; do  
  cd /misc/cache/by-branch/carbon/creedence/$i
  latest=`ls -ct | head -n 1`
  cd $latest/output/$i/RPMS/x86_64/
  sudo rpm -ivh *.rpm
done

