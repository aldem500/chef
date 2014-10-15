#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2014, 500px Inc.
#
# All rights reserved - Do Not Redistribute
#

file "/etc/apt/sources.list.d/brightbox.list" do
  action :delete
end

# apt_repository "nginx" do
#   uri "http://nginx.org/packages/ubuntu/"
#   distribution node['lsb']['codename']
#   components [ 'nginx' ]
#   key 'http://nginx.org/keys/nginx_signing.key'
# end

apt_repository "brightbox-ruby-ng-precise" do
  uri "http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu"
  distribution node['lsb']['codename']
  components [ 'main' ]
  keyserver 'keyserver.ubuntu.com'
  key 'C3173AA6'
  only_if { node['platform_version'].to_f == 12.04  }
end

package "nginx-extras" do
  action :install
  if node['platform_version'].to_f == 12.04
    version "1:1.2.9-1bbox1+ng~precise1"
  elsif node['platform_version'].to_f == 14.04
    version "1.4.6-1ubuntu3.1"
  end
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, 'service[nginx]'
end

template '/etc/default/nginx' do
  source 'nginx.erb'
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, 'service[nginx]'
end


cookbook_file '/etc/nginx/mime.types' do
  source "mime.types"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, 'service[nginx]'
end

directory "/etc/nginx/sites-enabled" do
  owner 'root'
  group 'root'
  action :create
end

link "/etc/nginx/sites-enabled/default" do
  action :delete
  notifies :restart, 'service[nginx]'
end


cookbook_file '/etc/logrotate.d/nginx' do
  source 'nginx'
  owner 'root'
  group 'root'
  mode 00644
end

cookbook_file '/etc/nginx/conf.d/log.conf' do
  source 'log.conf'
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, 'service[nginx]'
end

service 'nginx' do
  provider Chef::Provider::Service::Init::Debian
  supports :status => false, :start => true, :stop => true, :restart => true
  action :start
end
