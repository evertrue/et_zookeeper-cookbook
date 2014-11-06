set['exhibitor']['version'] = '1.5.2'
set['exhibitor']['snapshot_dir'] = '/mnt/zookeeper'
set['exhibitor']['transaction_dir'] = '/mnt/zookeeper'
set['exhibitor']['log_index_dir'] = '/mnt/zookeeper_log_indexes'

# Use S3 for Exhibitor's shared configuration

# Load encrypted credentials
aws_creds = Chef::EncryptedDataBagItem.load('secrets', 'aws_credentials')['ZookeeperS3']

set['exhibitor']['opts']['configtype'] = 's3'
set['exhibitor']['s3key'] = aws_creds['access_key_id']
set['exhibitor']['s3secret'] = aws_creds['secret_access_key']
set['exhibitor']['opts']['s3region'] = 'us-east-1'
set['exhibitor']['opts']['s3config'] = "ops.evertrue.com:zookeeper-#{node.chef_environment}"

default['et_exhibitor']['defaultconfig']['zoo_cfg_extra'] = {
  'tickTime' => '2000',
  'initLimit' => '11',
  'syncLimit' => '17',
  'autopurge.snapRetainCount' => '20',
  'autopurge.purgeInterval' => '1'
}

set['exhibitor']['defaultconfig']['auto_manage_instances'] = 1

default['java']['jdk_version'] = '7'
default['build_essential']['compiletime'] = true

set['zookeeper']['version'] = '3.4.6'
set['zookeeper']['mirror'] = 'http://apache.petsads.us/zookeeper/current/zookeeper-3.4.6.tar.gz'
set['zookeeper']['checksum'] = '01b3938547cd620dc4c93efe07c0360411f4a66962a70500b163b59014046994'
