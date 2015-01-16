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

node.set['exhibitor']['config']['zoo_cfg_extra'] =
  node['et_exhibitor']['defaultconfig']['zoo_cfg_extra']
    .map { |k, v| "#{k}\\=#{v}" }.join '&'

include_recipe 'exhibitor'
include_recipe 'exhibitor::service'
