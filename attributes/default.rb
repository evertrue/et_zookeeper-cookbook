set[:exhibitor][:snapshot_dir] = "/mnt/zookeeper"
set[:exhibitor][:transaction_dir] = "/mnt/zookeeper"
set[:exhibitor][:log_index_dir] = "/mnt/zookeeper_log_indexes"

default['et_exhibitor']['defaultconfig']['zoo_cfg_extra'] = {
  "tickTime" => "2000",
  "initLimit" => "10",
  "syncLimit" => "5",
  "autopurge.snapRetainCount" => "20",
  "autopurge.purgeInterval" => "1"
}
