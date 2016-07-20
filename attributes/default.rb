override['java']['jdk_version'] = '7'
override['build-essential']['compile_time'] = true

override['zookeeper']['service_style'] = 'exhibitor'

override['zookeeper']['config']['dataDir'] = '/mnt/zookeeper'
override['zookeeper']['config']['initLimit'] = '11'
override['zookeeper']['config']['syncLimit'] = '17'
override['zookeeper']['config']['autopurge.snapRetainCount'] = '20'
override['zookeeper']['config']['autopurge.purgeInterval'] = '1'

override['zookeeper']['env_vars'] = {
  'ZOO_LOG4J_PROP' => 'INFO,ROLLINGFILE',
  'ZOO_LOG_DIR' => node['zookeeper']['config']['dataDir']
}
