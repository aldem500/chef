
include_recipe "mysql"
package node['mysql']['package_name']
package "mytop"

template '/etc/mysql/debian.cnf' do
  source 'debian.cnf.erb'
  owner 'root'
  group 'root'
  mode 00600
end

template '/etc/mysql/my.cnf' do
  source 'my.cnf.erb'
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, 'service[mysql]'
end

#cookbook_file '/etc/mysql/debian-start' do
#  source 'debian-start'
#  owner 'root'
#  group 'root'
#  mode 00755
#  notifies :restart, 'service[mysql]'
#end
#
#cookbook_file '/etc/init.d/mysql' do
#  source 'mysql'
#  owner 'root'
#  group 'root'
#  mode 00755
#end

service 'mysql' do
  provider Chef::Provider::Service::Init::Debian
  pattern 'mysqld'
  supports :status => false, :start => true, :stop => true, :restart => true
  action :start
end
