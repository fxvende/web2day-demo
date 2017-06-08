#!/usr/bin/env bash

echo 'Get the firewall dep'
rake spec_clean && rake spec_prep

echo 'Create the two VMs'
kitchen create

echo 'Prepare Ubuntu VM'
kitchen login demo-ubuntu-16-04 <<EOF
sudo apt-get install -y --download-only apache2
exit
EOF

echo 'Prepare the RedHat VM'
kitchen login demo-centos-7 <<EOF
sudo yum install -y rsync
sudo yum install -y --downloadonly httpd
exit
EOF
