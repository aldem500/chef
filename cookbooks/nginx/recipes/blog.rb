include_recipe "nginx::default"
include_recipe "ssl::500px_pem"

template '/etc/nginx/sites-enabled/blog' do
  source 'blog.erb'
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, 'service[nginx]'
end


