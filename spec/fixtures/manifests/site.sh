#!/bin/bash

echo 'Run Puppet'
cd $(dirname $0)/data
rsync -az . /etc/puppetlabs/code/environments/production/modules
/opt/puppetlabs/bin/puppet apply --detailed-exitcodes demo/spec/fixtures/manifests/site.pp || test $? -eq 2
