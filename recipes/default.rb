#
# Cookbook Name:: devpiserver
# Recipe:: default
#

include_recipe 'python'

virt_path = node['devpiserver']['virtualenv']
devpi_user = node['devpiserver']['devpi_user']
devpi_group = node['devpiserver']['devpi_group']

devpicmd = "#{virt_path}/bin/devpi-server"
server_path = "/home/#{devpi_user}/.devpi/server"

# Creating devpi user and group
user devpi_user do
    home "/home/#{devpi_user}"
    password '$1$Q1zEFQ8c$BPLEZ2TRKgey0pvcQi38l/'
    shell '/bin/bash'
end

group devpi_group do
    action :modify
end

directory "/home/#{devpi_user}" do
    owner devpi_user
    group devpi_group
end

# Create a python virtualenv
python_virtualenv virt_path do
    owner devpi_user
    group devpi_group
    action :create
end

# Installing devpi-server
python_pip "devpi-server" do
    virtualenv virt_path
end

# Installing devpi-web
python_pip "devpi-web" do
    virtualenv virt_path
end

# Initialize devpi using sqlite
execute 'initialize-devpiserver' do
    command "#{devpicmd} --serverdir #{server_path} --init"
    user devpi_user
    not_if { File.exist?(server_path) }
end
