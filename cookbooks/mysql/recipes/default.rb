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
  keyserver 'keys.gnupg.net'
  key '1C4CBDCDCD2EFD2A'
end
