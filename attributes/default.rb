default['zookeeper']['version']     = '3.4.6'

default['et_zookeeper']['home_dir'] = '/mnt/zookeeper'
default['et_zookeeper']['data_dir'] = "#{node['et_zookeeper']['home_dir']}/data"
default['et_zookeeper']['log_dir']  = "#{node['et_zookeeper']['home_dir']}/logs"

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
