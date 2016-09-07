if node.chef_environment == '_default'
  default['et_monitoring']['datadog']['zookeeper'] = {
    instances: [{
      host: 'localhost',
      port: 2181,
      timeout: 8,
      tags: {
        zookeeper: node.chef_environment,
        env: node.chef_environment
      }
    }]
  }
end
