#
# Cookbook Name:: et_zookeeper
# Recipe:: default
#
# Copyright (C) 2013 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

# Set credentials for S3 access
aws_creds = data_bag_item('secrets', 'aws_credentials')['ZookeeperS3']
node.override['exhibitor']['s3']['access-key-id'] = aws_creds['access_key_id']
node.override['exhibitor']['s3']['access-secret-key'] = aws_creds['secret_access_key']

node.override['exhibitor']['config']['zoo-cfg-extra'] =
  node['et_exhibitor']['defaultconfig']['zoo-cfg-extra']
  .map { |k, v| "#{k}\\=#{v}" }.join '&'

include_recipe 'exhibitor'
include_recipe 'exhibitor::service'

if node.chef_environment == 'prod'
  node.override['et_monitoring']['datadog']['zookeeper'] = {
    instances: [{
      host: 'localhost',
      port: 2181,
      timeout: 8,
      tags: {
        zookeeper: node.chef_environment,
        env: node.chef_environment
      }
    }]
  }
end
