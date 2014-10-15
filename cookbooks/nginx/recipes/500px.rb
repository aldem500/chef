include_recipe "nginx::default"
include_recipe "ssl::500px_pem"

file "/etc/nginx/sites-enabled/app" do
  action :delete
end

template '/etc/nginx/sites-enabled/500px' do
  source '500px.erb'
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, 'service[nginx]'
end
