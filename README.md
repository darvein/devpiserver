# Devpi Server Chef Cookbook

A simple cookbook to install *devpi-server* and *devpi-web*.

## How it works
This cookbook is going to install devpi-server inside of a python virtualenv. The process will run as *devpi_user* overridable user.

### Running and testing
This cookbook can be tested by following steps:

~~~~
# Clone the repository
$ https://github.com/darvein/devpiserver
$ cd devpiserver
~~~~


~~~~
$ kitchen create
$ kitchen converge
$ kitchen verify
~~~~

~~~~
# If you want to get into the box by ssh
$ kitchen login
~~~~

It will generate a VM that will require VirtualBox and Vagrant.

You will be able to access to this devpi-server through web url:

http://[your computer IP address]:3141

## Configurations
Following attributes can be overriden:

~~~~
node['devpiserver']['devpi_user'] = 'devpi'
node['devpiserver']['devpi_group'] = 'devpi'

node['devpiserver']['devpi_host'] = '0.0.0.0'
node['devpiserver']['devpi_port'] = 3141

node['devpiserver']['virtualenv'] = '/opt/devpiserver'
~~~~

## TODO list
- Integrate devpi-server with postgres or mysql
