source :chef_server
source 'https://supermarket.chef.io'

metadata

group :integration do
  cookbook 'et_logger'
  cookbook 'myid_checker', path: 'test/integration/cookbooks/myid_checker'
  cookbook 'et_monitoring'
  cookbook 'datadog_client', path: 'test/integration/cookbooks/datadog_client'
end
