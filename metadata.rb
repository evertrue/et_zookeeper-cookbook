name             'et_zookeeper'
maintainer       'EverTrue, Inc.'
maintainer_email 'eric.herot@evertrue.com'
license          'All rights reserved'
description      'Installs/Configures et_zookeeper'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

depends 'apt'
depends 'build-essential'
depends 'zookeeper', '~> 1.4.6'
