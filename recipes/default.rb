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

case node['platform_family']
when 'debian'
  include_recipe 'apt'
end

include_recipe 'build-essential'

include_recipe 'zookeeper'

link '/etc/init.d/exhibitor' do
  to '/lib/init/upstart-job'
end

s = resources(service: 'exhibitor')
s.action [:enable, :start]
