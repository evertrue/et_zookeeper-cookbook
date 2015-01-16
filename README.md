# et_zookeeper cookbook

Wrapper cookbook for [SimpleFinance’s](https://github.com/SimpleFinance)
[zookeeper](https://github.com/SimpleFinance/chef-zookeeper) & [exhibitor](https://github.com/SimpleFinance/chef-exhibitor) cookbooks.

In addition to using these cookbooks to install Exhibitor and
Zookeeper, this cookbook sets up and enables [shared configuration using S3
for Exhibitor](https://github.com/Netflix/exhibitor/wiki/Shared-Configuration),
allowing Exhibitor to handle any additional configuration of the Zookeeper
ensemble.

# Requirements

* apt
* build-essential
* java
* zookeeper
* exhibitor

# Usage

Include the default recipe in a node’s run list.

If using with the [`apache_storm` cookbook](https://github.com/evertrue/apache_storm-cookbook), also ensure `role[zookeeper]` is included in the run list.

# Attributes

Attributes we override in the two base cookbooks:

* `node['zookeeper']['config']['dataDir']`
* `node['zookeeper']['config']['initLimit']`
* `node['zookeeper']['config']['syncLimit']`
* `node['zookeeper']['config']['autopurge.snapRetainCount']`
* `node['zookeeper']['config']['autopurge.purgeInterval']`
* `node['exhibitor']['version']`
* `node['exhibitor']['snapshot_dir']`
* `node['exhibitor']['transaction_dir']`
* `node['exhibitor']['log_index_dir']`
* `node['exhibitor']['cli']['configtype']`

Additional attributes provided by this cookbook:

* `node['exhibitor']['s3']['access-key-id']` – The IAM access key ID
* `node['exhibitor']['s3']['access-secret-key']` — The IAM secret access key
* `node['exhibitor']['cli']['s3region']` – AWS region used to communicate w/ S3
* `node['exhibitor']['cli']['s3config']` – S3 bucket & key name for the shared config file
* `node['et_exhibitor']['defaultconfig']['zoo_cfg_extra']` – Additional values used for the initial bootstrap; these are used to seed the S3 config file if it doesn’t already exist
* `node['java']['jdk_version']` – Which version of Java to install
* `node[:build_essential][:compiletime]` — Ensure that `build-essential` is installed at compile time; needed for some RubyGems to install properly

# Recipes

## default

1. Includes `apt::default` recipe to update apt on Debian systems
2. Sets additional Zookeeper config for Exhibitor to use
3. Includes `exhibitor::default`, which itself includes `zookeeper::install`, to install and set up Zookeeper and Exhibitor
4. Includes `exhibitor::service`, to set up and start the Exhibitor service via `runit`

# Author

Author:: EverTrue, Inc. (<devops@evertrue.com>)
