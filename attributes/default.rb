#
# Cookbook Name:: flugel_devpiserver
# Recipe:: default
#

default['flugel_devpiserver']['devpi_user'] = 'devpi'
default['flugel_devpiserver']['devpi_group'] = 'devpi'

default['flugel_devpiserver']['devpi_host'] = '127.0.0.1'
default['flugel_devpiserver']['devpi_port'] = 3141

default['flugel_devpiserver']['nginx_port'] = 8080

default['flugel_devpiserver']['virtualenv'] = '/opt/devpiserver'
