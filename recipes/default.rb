#
# Cookbook Name:: et_zookeeper
# Recipe:: default
#
# Copyright (C) 2013 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

node.set['exhibitor']['defaultconfig']['zoo_cfg_extra'] =
  node['et_exhibitor']['defaultconfig']['zoo_cfg_extra']
  .map { |k, v| "#{k}\\=#{v}" }
  .join '&'

include_recipe 'build-essential'

include_recipe 'zookeeper'

# Load encrypted credentials
aws_creds = Chef::EncryptedDataBagItem.load('secrets', 'aws_credentials')

# Set up S3 credentials for Exhibitor's shared config
template node[:exhibitor][:opts][:s3credentials] do
  backup false
  source 's3.conf.erb'
  variables(
    aws_creds: aws_creds['ZookeeperS3']
  )
  owner node[:zookeeper][:user]
  group node[:zookeeper][:group]
  mode '0600'
end

link '/etc/init.d/exhibitor' do
  to '/lib/init/upstart-job'
end

s = resources(service: 'exhibitor')
s.action [:enable, :start]
