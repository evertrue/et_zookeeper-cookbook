set['java']['jdk_version'] = '7'
set['build-essential']['compile_time'] = true

set['zookeeper']['service_style'] = 'exhibitor'

set['zookeeper']['config']['dataDir'] = '/mnt/zookeeper'
set['zookeeper']['config']['initLimit'] = '11'
set['zookeeper']['config']['syncLimit'] = '17'
set['zookeeper']['config']['autopurge.snapRetainCount'] = '20'
set['zookeeper']['config']['autopurge.purgeInterval'] = '1'

set['zookeeper']['env_vars'] = {
  'ZOO_LOG4J_PROP' => 'INFO,ROLLINGFILE',
  'ZOO_LOG_DIR' => node['zookeeper']['config']['dataDir']
}
