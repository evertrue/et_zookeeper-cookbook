# rubocop:disable SpaceBeforeFirstArg
name             'et_zookeeper'
maintainer       'EverTrue, Inc.'
maintainer_email 'devops@evertrue.com'
license          'All rights reserved'
description      'Installs/Configures et_zookeeper'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.0.1'

depends 'apt'
depends 'build-essential'
depends 'exhibitor',       '~> 0.5.0'
depends 'java'
