default[:mysql][:pass] = 'c2p55KaEy7Wap6Aw'
default[:mysql][:auto_increment_offset] = 1
default[:mysql][:server_id] = 1
default[:mysql][:innodb_buffer_pool_size] = "1G"
default[:mysql][:innodb_log_file_size] = "64M"
default[:mysql][:bind] = '0.0.0.0'
default[:mysql][:datadir] = "/var/lib/mysql"
default[:mysql][:package_name] = "percona-server-common-5.6 percona-server-server-5.6  percona-server-client-5.6"
default[:mysql][:innodb_thread_concurrency] = 2

default[:mysql2][:bind] = '127.0.0.2'
default[:mysql2][:datadir] = "/var/lib/mysql2"
default[:mysql2][:innodb_buffer_pool_size] = "1G"
default[:mysql2][:innodb_log_file_size] = "64M"
default[:mysql2][:server_id] = 2

default[:mysql3][:innodb_log_file_size] = "64M"
default[:mysql3][:datadir] = "/var/lib/mysql3"
