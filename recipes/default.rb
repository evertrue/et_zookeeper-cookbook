#
# Cookbook Name:: et_zookeeper
# Recipe:: default
#
# Copyright (C) 2013 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

node.set['java']['jdk_version'] = "7"

case node['platform_family']
  when "debian"
   include_recipe "apt"
end

node.set[:build_essential][:compiletime] = true

package "build-essential" do
  action :nothing
end.run_action(:install)

include_recipe "build-essential"
include_recipe "zookeeper"
