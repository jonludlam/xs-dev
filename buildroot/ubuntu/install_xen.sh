#!/bin/bash

# The following line fails when it tries to start the services
sudo apt-get install -y xen-system-amd64 || true 

echo "About to reboot. Please run 'vagrant up' to remount the NFS share, then 'vagrant ssh -c /vagrant/install_buildroot.sh' to complete the buildroot installation"

# Reboot to get into xen and then reconfigure the services
sudo reboot

