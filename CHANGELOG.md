et_zookeeper cookbook CHANGELOG
===============================
Changes for the et_zookeeper wrapper cookbook

v1.2.0 (2014-05-05)
-------------------
* Update to installing Exhibitor 1.5.2
    * Fixes quite a few bugs, including one w/ the rolling restart
* Fix the zoo.cfg extra properties to match production
* Clean up unused config files
* Set up Test Kitchen properly
* Use Berkshelf 3
* Add Rakefile with handy testing:
    * Foodcritic
    * Rubocop
    * ChefSpec
    * Test Kitchen w/ ServerSpec
* Add ChefSpec tests
* Add ServerSpec tests


v1.1.6 (2014-01-15)
-------------
* Fix attributes used for S3 credentials

v1.1.5 (2013-01-14)
-------------
* Update zookeeper cookbook to ~> 1.4.9
* Adjust attributes to take advantage of fixes in [zookeeper v1.4.9](https://github.com/SimpleFinance/chef-zookeeper/compare/v1.4.8...v1.4.9) re: S3 Exhibitor config
* Remove unnecessary code related to setting up Exhibitor's S3 config

v1.1.4 (2013-01/07)
-------------
* Revert to Exhibitor 1.5.0 (1.5.1 doesn't stay up & running for some reason)
* Remove unnecessary attribute setting
* Clean up some code as per Rubocop

v1.1.3 (2013-01-06)
-------------
* Update to Exhibitor 1.5.1 (released 2013-10-01)

v1.1.2 (2013-12-10)
-------------
* Ensure Exhibitor auto-manages instances by default

v1.1.1 (2013-12-10)
-------------
* Bump version number to unstick servers that already got a bad v1.1.0 version

v1.1.0 (2013-12-10)
-------------
* Add S3 shared config for Exhibitor
* Don't redefine `exhibitor` service in order to enable it
* Clean up Ruby formatting as per Rubocop

v1.0.0 (2013-12-06)
-------------
* Bump version number to reflect production usage

v0.1.2 (2013-12-02)
-------------
* Clean up Gemfile
* Ensure using latest Berkshelf, Test Kitchen, Kitchen Vagrant gems

v0.1.1 (2013-11-11)
-------------
* Move data from /tmp to /mnt
* Translate zoo_cfg_extra from hash to string
* Set opts: autopurge.snapRetainCount=20, autopurge.purgeInterval=1

v0.1.0 (2013-11-02)
-------------
* First rev!
