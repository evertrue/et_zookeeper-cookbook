name             'et_zookeeper'
maintainer       'EverTrue, Inc.'
maintainer_email 'devops@evertrue.com'
license          'All rights reserved'
description      'Installs/Configures et_zookeeper'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '5.0.6'

depends 'zookeeper', '~> 8.0'
depends 'storage'
depends 'filebeat'
depends 'ohai', '>= 4.0'
