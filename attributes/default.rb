default['zookeeper']['version']     = '3.4.6'
default['zookeeper']['checksum']    =
  '01b3938547cd620dc4c93efe07c0360411f4a66962a70500b163b59014046994'
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
