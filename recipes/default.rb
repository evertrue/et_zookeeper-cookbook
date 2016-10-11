#
# Cookbook Name:: et_zookeeper
# Recipe:: default
#
# Copyright (C) 2016 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

zookeeper node['zookeeper']['version'] do
  user_home node['et_zookeeper']['home_dir']
  data_dir node['et_zookeeper']['data_dir']
end

zookeeper_config 'zoo.cfg' do
  config(
    'dataDir' => node['et_zookeeper']['data_dir'],
    'clientPort' => 2181,
    'initLimit' => 11,
    'syncLimit' => 17,
    'autopurge.snapRetainCount' => 20,
    'autopurge.purgeInterval' => 1
  )
  env_vars('ZOO_LOG4J_PROP' => 'INFO,ROLLINGFILE')
  log_dir node['et_zookeeper']['log_dir']
end

zookeeper_service 'zookeeper'

ohai_plugin 'et_zookeeper'
ohai_plugin 'myid'
