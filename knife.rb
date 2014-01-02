#
current_dir = File.dirname(__FILE__)
log_level		:info
log_location		STDOUT
node_name               "admin" 
client_key               "/etc/chef-server/admin.pem"
validation_client_name   "chef-validator"
validation_key           "/etc/chef-server/chef-validator.pem"
chef_server_url          "https://mychef"
cookbook_path            ["/work/chef/cookbooks"]
cookbook_copyright 	"Aldemware"
cookbook_license 	"apachev2"
cookbook_email 		"cookbooks@aldemware.com"

