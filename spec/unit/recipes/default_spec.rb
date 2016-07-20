require 'spec_helper'

describe 'et_zookeeper::default' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new do |_node, server|
      server.create_client('et_zookeeper_spec', admin: true)
      server.create_environment('_default', description: 'Default env')
      server.create_data_bag(
        'secrets',
        'aws_credentials' => {
          'ZookeeperS3' => {
            'access_key_id' => 'AAAAAAAAAAAAAAAAAAAA',
            'secret_access_key' => 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
          }
        }
      )
    end.converge(described_recipe)
  end

  %w(
    exhibitor::default
    exhibitor::service
  ).each do |recipe|
    it "includes #{recipe}" do
      expect(chef_run).to include_recipe recipe
    end
  end
end
