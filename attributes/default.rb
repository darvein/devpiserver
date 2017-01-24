#
# Cookbook Name:: devpiserver
# Recipe:: default
#

default['devpiserver']['devpi_user'] = 'devpi'
default['devpiserver']['devpi_group'] = 'devpi'

default['devpiserver']['devpi_host'] = '127.0.0.1'
default['devpiserver']['devpi_port'] = 3141

default['devpiserver']['nginx_port'] = 8080

default['devpiserver']['virtualenv'] = '/opt/devpiserver'
