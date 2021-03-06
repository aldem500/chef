include_recipe "nginx::default"
#include_recipe "ssl::500px_pem"

package "php5-fpm php5-mysql"

cookbook_file '/etc/php5/fpm/php.ini' do
  source 'php.ini'
  owner 'root'
  group 'root'
  mode 00644
#  notifies :restart, 'service[php5-fpm]'
end

execute "restartPHP5-FPM" do
  command "/etc/init.d/php5-fpm restart"
#  cwd "/home/#{node["haproxyUser"]}/haproxy"
  action :nothing
end


link "/etc/nginx/sites-enabled/default" do
  action :delete
  notifies :restart, 'service[nginx]'
end

cookbook_file '/etc/nginx/sites-enabled/lemp' do
  source 'lemp'
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, 'service[nginx]'
end

cookbook_file '/usr/share/nginx/html/info.php' do
  source 'info.php'
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, 'service[nginx]'
end

#service 'php5-fpm' do
#  provider Chef::Provider::Service::Init::Debian
#  supports :status => false, :start => true, :stop => true, :restart => true
#  action :start
#end
