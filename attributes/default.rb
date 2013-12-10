set[:exhibitor][:snapshot_dir] = '/mnt/zookeeper'
set[:exhibitor][:transaction_dir] = '/mnt/zookeeper'
set[:exhibitor][:log_index_dir] = '/mnt/zookeeper_log_indexes'

# Use S3 for Exhibitor's shared configuration
set[:exhibitor][:opts][:configtype] = 's3'
default[:exhibitor][:opts][:s3credentials] = "#{node[:zookeeper][:install_dir]}/s3.conf"
default[:exhibitor][:opts][:s3region] = 'us-east-1'
default[:exhibitor][:opts][:s3config] = "ops.evertrue.com:zookeeper-#{node.chef_environment}"

default['et_exhibitor']['defaultconfig']['zoo_cfg_extra'] = {
  'tickTime' => '2000',
  'initLimit' => '10',
  'syncLimit' => '5',
  'autopurge.snapRetainCount' => '20',
  'autopurge.purgeInterval' => '1'
}

set['exhibitor']['defaultconfig']['auto_manage_instances'] = 0

default['java']['jdk_version'] = '7'
default[:build_essential][:compiletime] = true
set['zookeeper']['mirror'] = 'http://mirror.metrocast.net/apache/zookeeper/zookeeper-3.4.5/zookeeper-3.4.5.tar.gz'
