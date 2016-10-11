name             'et_zookeeper'
maintainer       'EverTrue, Inc.'
maintainer_email 'devops@evertrue.com'
license          'All rights reserved'
description      'Installs/Configures et_zookeeper'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '4.0.4'

depends 'exhibitor', '~> 2.0'
depends 'ohai', '>= 4.0'
