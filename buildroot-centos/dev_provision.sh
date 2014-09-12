#!/bin/bash

rpm -ivh http://mirror.ancl.hawaii.edu/linux/epel/6/i386/epel-release-6-8.noarch.rpm

yum install -y git mock redhat-lsb-core emacs cachefilesd

cat > /etc/sysconfig/modules/cachefiles.modules <<EOF
#!/bin/sh

if [ ! -c /dev/cachefiles ]; then
        exec /sbin/modprobe cachefiles > /dev/null 2>&1
fi

EOF

chmod +x /etc/sysconfig/modules/cachefiles.modules

usermod -a -G mock vagrant


