#!/bin/bash

curl -O https://packages.chef.io/files/stable/chef/12.19.36/el/7/chef-12.19.36-1.el7.x86_64.rpm
rpm -ivh chef-12.19.36-1.el7.x86_64.rpm
rm -f chef-12.19.36-1.el7.x86_64.rpm

#ubunut
curl -O https://packages.chef.io/files/stable/chef/12.19.36/ubuntu/16.04/chef_12.19.36-1_amd64.deb
dpkg -i chef_12.19.36-1_amd64.deb
rm -f chef_12.19.36-1_amd64.deb
