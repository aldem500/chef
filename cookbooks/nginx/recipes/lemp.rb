include_recipe "nginx::default"
#include_recipe "ssl::500px_pem"

package "php5-fpm php5-mysql"

cookbook_file '/etc/php5/fpm/php.ini' do
  source 'php.ini'
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, 'service[php5-fpm]'
end

link "/etc/nginx/sites-enabled/default" do
  action :delete
  notifies :restart, 'service[nginx]'
end

template '/etc/nginx/sites-enabled/lemp' do
  source 'lemp.erb'
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

