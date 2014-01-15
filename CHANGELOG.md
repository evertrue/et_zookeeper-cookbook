## 1.1.6

* Fix attributes used for S3 credentials

## 1.1.5

* Update zookeeper cookbook to ~> 1.4.9
* Adjust attributes to take advantage of fixes in [zookeeper v1.4.9](https://github.com/SimpleFinance/chef-zookeeper/compare/v1.4.8...v1.4.9) re: S3 Exhibitor config
* Remove unnecessary code related to setting up Exhibitor's S3 config

## 1.1.4

* Revert to Exhibitor 1.5.0 (1.5.1 doesn't stay up & running for some reason)
* Remove unnecessary attribute setting
* Clean up some code as per Rubocop

## 1.1.3

* Update to Exhibitor 1.5.1 (released 2013-10-01)

## 1.1.2

* Ensure Exhibitor auto-manages instances by default

## 1.1.1

* Bump version number to unstick servers that already got a bad v1.1.0 version

## 1.1.0

* Add S3 shared config for Exhibitor
* Don't redefine `exhibitor` service in order to enable it
* Clean up Ruby formatting as per Rubocop

## 1.0.0

* Bump version number to reflect production usage

## 0.1.2

* Clean up Gemfile
* Ensure using latest Berkshelf, Test Kitchen, Kitchen Vagrant gems

## 0.1.1

* Move data from /tmp to /mnt
* Translate zoo_cfg_extra from hash to string
* Set opts: autopurge.snapRetainCount=20, autopurge.purgeInterval=1

## 0.1.0

* First rev!
