#
# Cookbook Name:: devpiserver
# Recipe:: default
#

include_recipe 'nginx'

devpi_port = node['devpiserver']['devpi_port']
devpi_user = node['devpiserver']['devpi_user']
nginx_port = node['devpiserver']['nginx_port']
server_path = "/home/#{devpi_user}/.devpi/server"

service 'nginx' do
    supports :status => true, :restart => true, :reload => true
    action   :enable
end

# Setting devpi-nginx template
template '/etc/nginx/sites-enabled/devpi-nginx.conf' do
    source 'devpi-nginx.conf.rb'
    owner 'root'
    group 'root'
    mode '0775'
    variables ({
        :server_path => server_path,
        :devpi_port => devpi_port,
        :nginx_port => nginx_port
    })
    notifies :reload, 'service[nginx]', :immediately
end

