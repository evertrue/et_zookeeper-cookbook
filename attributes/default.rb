default['et_zookeeper']['cluster_name'] = 'evertrue'
default['et_zookeeper']['jmx_port']     = 21_801
default['et_zookeeper']['jmx_enabled']  = true

if node.chef_environment == 'prod'
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
