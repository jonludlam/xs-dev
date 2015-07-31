#!/bin/bash


mv CentOS-Base.repo /etc/yum.repos.d/
mv RPM-GPG-KEY-Citrix-6.6 /etc/pki/rpm-gpg
mv RPM-GPG-KEY-EPEL-7 /etc/pki/rpm-gpg

yum clean all
yum update -y
yum install -y yum-utils vim emacs git cachefilesd

cat > /etc/sysconfig/modules/cachefiles.modules <<EOF
#!/bin/sh

if [ ! -c /dev/cachefiles ]; then
        exec /sbin/modprobe cachefiles > /dev/null 2>&1
fi

EOF

chmod +x /etc/sysconfig/modules/cachefiles.modules

modprobe cachefiles

service cachefilesd start

usermod -a -G mock vagrant

sed s/@XS_BRANCH@/trunk-ring3/g Citrix.repo.in > Citrix.repo

sudo mv Citrix.repo /etc/yum.repos.d/

yum-builddep -y xapi
yum-builddep -y xenvm

echo camos.uk.xensource.com:/vol/sources/sources /usr/groups/sources nfs rsize=65536,wsize=65536,proto=tcp,timeo=600,intr,fsc >> /etc/fstab
echo filer02.uk.xensource.com:/vol/groups/linux/distfiles /usr/groups/linux/distfiles nfs rsize=65536,wsize=65536,proto=tcp,timeo=600,intr,fsc >> /etc/fstab

sudo mkdir -p /usr/groups/sources
sudo mkdir -p /usr/groups/linux/distfiles

sudo mount /usr/groups/sources
sudo mount /usr/groups/linux/distfiles

