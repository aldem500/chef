#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, 500px Inc.
#
# All rights reserved - Do Not Redistribute
#

apt_repository "percona" do
  uri "http://repo.percona.com/apt"
  distribution node['lsb']['codename']
  components [ 'main' ]
  keyserver 'keyserver.ubuntu.com'
  key 'CD2EFD2A'
end
