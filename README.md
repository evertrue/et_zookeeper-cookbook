# et_zookeeper cookbook

Wrapper cookbook for [SimpleFinance’s](https://github.com/SimpleFinance)
[zookeeper cookbook](https://github.com/SimpleFinance/chef-zookeeper).
In addition to using the `zookeeper` cookbook to install Exhibitor and
Zookeeper, this cookbook sets up and enables [shared configuration using S3
for Exhibitor](https://github.com/Netflix/exhibitor/wiki/Shared-Configuration),
allowing Exhibitor to handle any additional configuration of the Zookeeper
ensemble.

# Requirements

* apt
* build-essential
* zookeeper
* java

# Usage

Include the default recipe, as well as `role[zookeeper]`, in a node’s run list.

# Attributes

Attributes we override in the base zookeeper cookbook:

* `node[:exhibitor][:snapshot_dir]`
* `node[:exhibitor][:transaction_dir]`
* `node[:exhibitor][:log_index_dir]`
* `node[:exhibitor][:opts][:configtype]`
default[:exhibitor][:opts][:s3credentials]`}/s3.conf"
* `node['exhibitor']['defaultconfig']['auto_manage_instances']`
* `node['zookeeper']['mirror']`

Additional attributes provided by this cookbook:

* `node[:exhibitor][:opts][:s3region]` – AWS region used to communicate w/ S3
* `node[:exhibitor][:opts][:s3config]` – S3 bucket & key name for the shared config file
* `node['et_exhibitor']['defaultconfig']['zoo_cfg_extra']`
* `node['java']['jdk_version']`
* `node[:build_essential][:compiletime]`

# Templates

# s3.conf.erb

Provides for a file to be created on the node containing necessary S3
credentials for Exhibitor to use.

# Recipes

## default

* Sets additional Zookeeper config for Exhibitor to use
* Ensures the JDK version
* Stores a file containing necessary S3 credentials on the node itself
* Links Exhibitor’s init script to Upstart’s jobs directory
* Enables & (re)starts Exhibitor’s service.

# Author

Author:: EverTrue, Inc. (<devops@evertrue.com>)
