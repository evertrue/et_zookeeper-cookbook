#
# Cookbook Name:: et_zookeeper
# Recipe:: default
#
# Copyright (C) 2013 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

case node['platform_family']
when 'debian'
  include_recipe 'apt'
end

# Set credentials for S3 access
aws_creds = data_bag_item('secrets', 'aws_credentials')['ZookeeperS3']
node.override['exhibitor']['s3']['access-key-id'] = aws_creds['access_key_id']
node.override['exhibitor']['s3']['access-secret-key'] = aws_creds['secret_access_key']

node.override['exhibitor']['config']['zoo_cfg_extra'] =
  node['et_exhibitor']['defaultconfig']['zoo_cfg_extra']
  .map { |k, v| "#{k}\\=#{v}" }.join '&'

include_recipe 'exhibitor'
include_recipe 'exhibitor::service'
