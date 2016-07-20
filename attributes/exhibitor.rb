override['exhibitor']['version'] = '1.5.2'
override['exhibitor']['snapshot_dir'] = '/mnt/zookeeper'
override['exhibitor']['transaction_dir'] = '/mnt/zookeeper'
override['exhibitor']['log_index_dir'] = '/mnt/zookeeper_log_indexes'

# Use S3 for Exhibitor's shared configuration

override['exhibitor']['cli']['configtype'] = 's3'
override['exhibitor']['cli']['s3region'] = 'us-east-1'
override['exhibitor']['cli']['s3config'] = "ops.evertrue.com:zookeeper-#{node.chef_environment}"

default['et_exhibitor']['defaultconfig']['zoo_cfg_extra'] = {
  'tickTime' => '2000',
  'initLimit' => '11',
  'syncLimit' => '17',
  'autopurge.snapRetainCount' => '20',
  'autopurge.purgeInterval' => '1'
}
