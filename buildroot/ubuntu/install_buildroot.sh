#!/bin/bash

sudo apt-get -f install

sudo apt-add-repository "deb http://10.80.239.213:8080/job/xenserver-buildroot/distribution=ubuntu/lastSuccessfulBuild/artifact/RPMS/ ./" 

sudo apt-get update

sudo apt-get install -y --force-yes xenserver-install-wizard xapi xapi-xe xe-create-templates xenopsd-libvirt xenopsd-simulator xenopsd-xc xenops-cli ffs sm-cli xcp-sm xcp-networkd xcp-rrdd squeezed linux-guest-loader

sudo cp /vagrant/xenopsd.conf /etc/

