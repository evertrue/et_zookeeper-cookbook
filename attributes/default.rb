default['java']['jdk_version'] = '7'
default['build_essential']['compiletime'] = true

set['zookeeper']['service_style'] = 'exhibitor'

set['zookeeper']['config']['dataDir'] = '/mnt/zookeeper'
set['zookeeper']['config']['initLimit'] = '11'
set['zookeeper']['config']['syncLimit'] = '17'
set['zookeeper']['config']['autopurge.snapRetainCount'] = '20'
set['zookeeper']['config']['autopurge.purgeInterval'] = '1'
