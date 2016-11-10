#
# Cookbook Name:: et_zookeeper
# Recipe:: default
#
# Copyright (C) 2016 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'storage'

node.default['et_zookeeper']['home_dir'] =
  if node['storage']['ephemeral_mounts']
    "#{node['storage']['ephemeral_mounts'].first}/zookeeper"
  else
    '/mnt/zookeeper'
  end

node.default['et_zookeeper']['data_dir'] = "#{node['et_zookeeper']['home_dir']}/data"
node.default['et_zookeeper']['log_dir']  = "#{node['et_zookeeper']['home_dir']}/logs"

# Generate an ID from the node IP address
myid = EtZookeeper::Helpers.name2id node.name

# Find other nodes in the cluster
zk_nodes = search(
  :node,
  "chef_environment:#{node.chef_environment} AND " \
    "et_zookeeper_cluster_name:#{node['et_zookeeper']['cluster_name']}",
  filter_result: {
    'name' => %w(name),
    'myid' => %w(et_zookeeper myid),
    'ipaddress' => %w(ipaddress)
  }
)

# Bail if my ID is not unique in the cluster
zk_nodes.each do |zk_node|
  next unless zk_node['name'] != node.name && zk_node['myid'] == myid
  raise "myid #{myid} is already in use by #{zk_node['name']}"
end

node.default['et_zookeeper']['myid'] = myid

zookeeper node['zookeeper']['version'] do
  user_home node['et_zookeeper']['home_dir']
  data_dir node['et_zookeeper']['data_dir']
end

file "#{node['et_zookeeper']['data_dir']}/myid" do
  content myid.to_s
  owner   'zookeeper'
  group   'zookeeper'
end

config_hash = {
  'dataDir' => node['et_zookeeper']['data_dir'],
  'clientPort' => 2181,
  'initLimit' => 100,
  'syncLimit' => 17,
  'autopurge.snapRetainCount' => 20,
  'autopurge.purgeInterval' => 1
}.merge(
  zk_nodes.each_with_object({}) do |zk_node, m|
    m["server.#{zk_node['myid']}"] = "#{zk_node['name']}:2888:3888"
  end
).merge("server.#{myid}" => "#{node.name}:2888:3888") # Ensure the local node is always included

Chef::Log.debug("Zookeeper Config Hash: #{config_hash.inspect}")

zookeeper_config 'zoo.cfg' do
  config config_hash
  env_vars('ZOO_LOG4J_PROP' => 'INFO,ROLLINGFILE')
  java_opts node['zookeeper']['java_opts']
  log_dir node['et_zookeeper']['log_dir']
end

zookeeper_service 'zookeeper'

ohai_plugin 'et_zookeeper'
ohai_plugin 'myid'
