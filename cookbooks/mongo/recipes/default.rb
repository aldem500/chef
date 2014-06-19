#
# Cookbook Name:: mongo
# Recipe:: default
#
# Copyright 2014, Aldemware
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "apt"

template '/etc/default/mongodb' do
  source 'mongodb.erb'
  owner 'root'
  group 'root'
  mode 00644
end 

apt_repository "mongodb" do
  uri "http://downloads-distro.mongodb.org/repo/ubuntu-upstart/"
  distribution 'dist'
  components [ '10gen' ]
  keyserver 'keyserver.ubuntu.com'
  key '7F0CEB10'
end

package "mongodb-10gen" do
  version "2.4.10"
  options "--force-yes"
  ignore_failure true
end

["mongos", "mongodb", "mongoconf"].each do |type|
  template "/etc/#{type}.conf" do
    source "#{type}.conf.erb"
    owner 'root'
    group 'root'
    mode 00644
    notifies node[:mongo][type][:enabled] ? :restart : :stop, "service[#{type}]"
    action node[:mongo][type][:enabled] ? :create : :delete
  end 

cookbook_file '/etc/mongodb1.conf' do
  source 'mongodb1.conf'
  owner 'root'
  group 'root'
  mode 00644
end

cookbook_file '/etc/mongodb2.conf' do
  source 'mongodb2.conf'
  owner 'root'
  group 'root'
  mode 00644
end

cookbook_file '/etc/mongodb3.conf' do
  source 'mongodb3.conf'
  owner 'root'
  group 'root'
  mode 00644
end

  cookbook_file "/etc/init/#{type}.conf" do
    source "#{type}.conf"
    owner 'root'
    group 'root'
    mode 00644
    notifies node[:mongo][type][:enabled] ? :restart : :stop, "service[#{type}]"
    action node[:mongo][type][:enabled] ? :create : :delete
  end

  link "/etc/init.d/#{type}" do
    to '/lib/init/upstart-job'
    action node[:mongo][type][:enabled] ? :create : :delete
  end

  service type do
    provider Chef::Provider::Service::Upstart
    supports :status => false, :start => true, :stop => true, :restart => true
    action node[:mongo][type][:enabled] ? :start : :stop
  end
end

