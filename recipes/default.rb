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

node.set['exhibitor']['defaultconfig']['zoo_cfg_extra'] = node['et_exhibitor']['defaultconfig']['zoo_cfg_extra'].map { |k,v|
    "#{k}\\=#{v}"
  }.join('&')

include_recipe "build-essential"
include_recipe "zookeeper"

link "/etc/init.d/exhibitor" do
  to "/lib/init/upstart-job"
end

service "exhibitor" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end
