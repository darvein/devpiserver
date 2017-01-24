#
# Cookbook Name:: devpiserver
# Recipe:: supervisor
#

include_recipe 'supervisor'
include_recipe 'devpiserver'

virt_path = node['devpiserver']['virtualenv']
devpi_port = node['devpiserver']['devpi_port']
devpi_user = node['devpiserver']['devpi_user']
devpi_group = node['devpiserver']['devpi_group']
devpi_host = node['devpiserver']['devpi_host']

devpicmd = "#{virt_path}/bin/devpi-server"
server_path = "/home/#{devpi_user}/.devpi/server"

supervisor_service 'devpi_server' do
    action :enable
    command("#{devpicmd} --serverdir #{server_path} --port #{devpi_port} --host #{devpi_host} --no-events --offline-mode --no-root-pypi")
    user devpi_user
end

#supervisor_service 'devpi_server' do
#    action :stop
#end

# Re index takes some time
#execute 'reindex-devpiserver' do
#    command "#{devpicmd} --recreate-search-index --serverdir #{server_path}"
#    user devpi_user
#end

supervisor_service 'devpi_server' do
    action :restart
end
