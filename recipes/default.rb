#
# Cookbook Name:: et_zookeeper
# Recipe:: default
#
# Copyright (C) 2013 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

server_number = 2

search(:node,"roles:zookeeper AND " +
  "chef_environment:#{node.chef_environment}").each do |n|
  unless n.name == node.name
    node.set['et_exhibitor']['defaultconfig']['zoo_cfg_extra']["server.#{server_number}"] = "#{n['ipaddress']}\:2888\:3888"
    Chef::Log.info("ADDING SERVER: " + "#{n['ipaddress']}\:2888\:3888")
    server_number += 1
  end
end

node.set['exhibitor']['defaultconfig']['zoo_cfg_extra'] = node['et_exhibitor']['defaultconfig']['zoo_cfg_extra'].map { |k,v|
    "#{k}\\=#{v}"
  }.join('&')

include_recipe "build-essential"

node.override['java']['jdk_version'] = "7"

include_recipe "zookeeper"

link "/etc/init.d/exhibitor" do
  to "/lib/init/upstart-job"
end

service "exhibitor" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end
