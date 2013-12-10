#
# Cookbook Name:: et_zookeeper
# Recipe:: default
#
# Copyright (C) 2013 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

server_number = 2

# Build a list of Zookeeper nodes via Chef Search to use in zoo.cfg
# see zookeeper.apache.org/doc/current/zookeeperAdmin.html#sc_zkMulitServerSetup
# for details on why this is necessary
search(:node, 'roles:zookeeper AND ' +
  "chef_environment:#{node.chef_environment}").each do |n|
  unless n.name == node.name
    node.set['et_exhibitor']['defaultconfig']['zoo_cfg_extra']["server.#{server_number}"] = "#{n['ipaddress']}\:2888\:3888"
    Chef::Log.info("ADDING SERVER: #{n['ipaddress']}\:2888\:3888")

    # Seems that the `:snapshot_dir` is what's used for the ZK data dir
    # See github.com/SimpleFinance/chef-zookeeper/blob/master/templates/default/defaultconfig.exhibitor.erb#L1
    # The `content` has to be a string, thus the interpolation
    file "#{node[:exhibitor][:snapshot_dir]}/myid" do
      action :create
      backup false
      content "#{server_number}"
      mode 644
      owner node[:zookeeper][:user]
    end

    server_number += 1
  end
end

node.set['exhibitor']['defaultconfig']['zoo_cfg_extra'] = node['et_exhibitor']['defaultconfig']['zoo_cfg_extra'].map { |k, v|
  "#{k}\\=#{v}"
}.join('&')

include_recipe 'build-essential'

node.override['java']['jdk_version'] = '7'

include_recipe 'zookeeper'

link '/etc/init.d/exhibitor' do
  to '/lib/init/upstart-job'
end

s = resources(:service => 'exhibitor')
s.action [:enable, :start]
