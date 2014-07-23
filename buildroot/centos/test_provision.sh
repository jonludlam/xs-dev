#!/bin/bash

rpm -ivh http://mirror.ancl.hawaii.edu/linux/epel/6/i386/epel-release-6-8.noarch.rpm

cat > /etc/yum.repos.d/buildroot.repo << EOF
[ring3]
name=buildroot
enabled=1
baseurl=http://10.80.239.213:8080/job/xenserver-buildroot/distribution=centos/lastSuccessfulBuild/artifact/RPMS/
gpgcheck=0
EOF

cat > /etc/yum.repos.d/xen-c6-tweaked.repo << EOF
[xen-c6-tweaked]
name=CentOS-$releasever - XenServer temporary Xen override
baseurl=http://xenbits.xen.org/djs/xen-c6-tweaked/RPMS/
gpgcheck=0
Priority=1
enabled=1

[xen-c6]
name=CentOS-$releasever - Xen
baseurl=http://dev.centos.org/centos/6/xen-c6/\$basearch/
gpgcheck=0
Priority=1
enabled=1

[xen-c6-source]
name=CentOS-$releasever - Xen Source
baseurl=http://dev.centos.org/centos/6/xen-c6/SRPMS/
gpgcheck=0
Priority=1
enabled=0
EOF

yum clean all
yum update -y
yum install -y xenserver-core


