
include_recipe "mysql::default"
package "percona-server-server-5.5"
package "mytop"

directory "/etc/mysql3" do
  owner 'root'
  group 'root'
  mode  00755
  action :create
end

directory "/var/run/mysqld3" do
  owner 'mysql'
  group 'root'
  mode  00755
  action :create
end

directory "/var/log/mysql3" do
  owner 'mysql'
  group 'adm'
  mode  02750
  action :create
end

directory "/var/lib/mysql3" do
  owner 'mysql'
  group 'mysql'
  mode  00755
  action :create
end

cookbook_file '/etc/mysql3/debian.cnf' do
  source 'debian3.cnf'
  owner 'root'
  group 'root'
  mode 00600
  notifies :restart, 'service[mysql3]'
end

cookbook_file '/etc/mysql3/debian-start' do
  source 'debian-start3'
  owner 'root'
  group 'root'
  mode 00755
  notifies :restart, 'service[mysql3]'
end


template '/etc/mysql3/my.cnf' do
  source 'my3.cnf.erb'
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, 'service[mysql3]'
end

cookbook_file '/etc/init.d/mysql3' do
  source 'mysql3'
  owner 'root'
  group 'root'
  mode 00755
end

cookbook_file '/usr/bin/mysql3' do
  source 'mysql3.client'
  owner 'root'
  group 'root'
  mode 00755
end

service 'mysql3' do
  provider Chef::Provider::Service::Init::Debian
#  pattern '/usr/bin/mysqld_safe --defaults-file=/etc/mysql3/my.cnf'
  supports :status => true, :start => true, :stop => true, :restart => true
  action :start
end
