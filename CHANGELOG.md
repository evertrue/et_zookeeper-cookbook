et_zookeeper cookbook CHANGELOG
===============================
Changes for the et_zookeeper wrapper cookbook

v5.0.4 (2017-02-07)
-------------------
* Optimize cluster settings
    - `initLimit` to 120 seconds
    - `autopurge.snapRetainCount` to 3

v5.0.3 (2016-11-17)
-------------------
* Enable JMX

v5.0.2 (2016-11-10)
-------------------
* Pass java_opts to zookeeper_config resource
* Let application cookbook set the version

v5.0.1 (2016-11-09)
-------------------
* Bump initLimit to 100

v5.0.0 (2016-10-13)
-------------------
* Drop exhibitor cookbook (and associated attributes) and use ZK cookbook directly
* Bump ZK version: 3.4.9
* Use storage cookbook to manage ephemeral storage

v4.0.5 (2016-10-11)
-------------------
* Add an Ohai plugin to read myid into an attribute (allows for compatibility with what we hope will be v5)
* Modernize kitchen yaml

v4.0.4 (2016-10-06)
-------------------
* Re-enable reboot coordinator

v4.0.3 (2016-09-13)
-------------------
* Disable reboot coordinator

v4.0.2 (2016-09-07)
-------------------
* Test that datadog agent gets installed and configured
* Move datadog config to attributes file with default precedence so that it will actually run
* Switch to tcp-style test for datadog check
* Stop definining the cookbook attribute for datadog

v4.0.1 (2016-09-07)
-------------------
* Add Datadog attributes

v4.0.0 (2016-07-22)
-------------------
* Update `exhibitor` cookbook to `~> v2.0`
    - Also updates the `zookeeper` cookbook to `~> 5.0`
* Drop unnecessary dependencies
    - The `exhibitor` cookbook nicely wraps these, so simplifying the dep graph is a Good Thing™
* Clean up README
* Avoid using set/normal level attributes & drop unused/unnecessary attributes

v3.0.0 (2016-05-18)
-------------------
* Update `exhibitor` cookbook
    - Also updates the `zookeeper` cookbook, bringing in a bunch of fixes
* Fix up testing

v2.0.1 (2015-08-11)
-------------------
* Update exhibitor cookbook
    - Drop zookeeper as a dependency b/c exhibitor already depends on it
* Add `zookeeper-env.sh` attribute values to move `zookeeper.out` log & lower log noise
* Switch to running Test Kitchen using EC2
* Drop using real data bag items in favor of dummy items

v2.0.0 (2015-01-16)
-------------------
* Refactor using zookeeper ~> v2.0 & exhibitor ~> 0.4.0 cookbooks
* Clean up some configs

v1.2.1 (2014-11-06)
-------------------
* Update to installing Zookeeper 3.4.6
* Fix mirror to use for downloading ZK
* Use Supermarket for community cookbooks
* Fix Serverspec spec_helper

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
