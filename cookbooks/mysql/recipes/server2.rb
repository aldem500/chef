
include_recipe "mysql::default"
package node['mysql']['package_name']
package "mytop"

directory "/etc/mysql2" do
  owner 'root'
  group 'root'
  mode  00755
  action :create
end

directory "/var/run/mysqld2" do
  owner 'mysql'
  group 'root'
  mode  00755
  action :create
end

directory "/var/log/mysql2" do
  owner 'mysql'
  group 'adm'
  mode  02750
  action :create
end

directory "#{node[:mysql2][:datadir]}" do
  owner 'mysql'
  group 'mysql'
  mode  00755
  action :create
end

cookbook_file '/etc/mysql2/debian.cnf' do
  source 'debian2.cnf'
  owner 'root'
  group 'root'
  mode 00600
  notifies :restart, 'service[mysql2]'
end

cookbook_file '/etc/mysql2/debian-start' do
  source 'debian-start2'
  owner 'root'
  group 'root'
  mode 00755
  notifies :restart, 'service[mysql2]'
end


template '/etc/mysql2/my.cnf' do
  source 'my2.cnf.erb'
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, 'service[mysql2]'
end

cookbook_file '/etc/init.d/mysql2' do
  source 'mysql2'
  owner 'root'
  group 'root'
  mode 00755
end

cookbook_file '/usr/bin/mysql2' do
  source 'mysql2.client'
  owner 'root'
  group 'root'
  mode 00755
end

service 'mysql2' do
  provider Chef::Provider::Service::Init::Debian
#  pattern '/usr/bin/mysqld_safe --defaults-file=/etc/mysql2/my.cnf'
  supports :status => true, :start => true, :stop => true, :restart => true
  action :start
end

## to start on reboot
# update-rc.d mysql2 defaults
