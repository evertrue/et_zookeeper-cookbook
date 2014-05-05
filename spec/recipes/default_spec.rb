require 'spec_helper'

describe 'et_zookeeper::default' do
  let(:chef_run) do
    ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe)
  end

  before do
    ChefSpec::Server.create_client('et_zookeeper_spec', admin: true)
    ChefSpec::Server.create_environment('_default', description: 'Default env')
    Chef::EncryptedDataBagItem.stub(:load).with('secrets', 'aws_credentials')
      .and_return(
        'ZookeeperS3' => {
          'access_key_id' => 'AAAAAAAAAAAAAAAAAAAA',
          'secret_access_key' => 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
        }
      )
  end

  %w(
    apt::default
    build-essential::default
    zookeeper::default
  ).each do |recipe|
    it "includes #{recipe}" do
      expect(chef_run).to include_recipe recipe
    end
  end

  it 'creates a link to exhibitor’s upstart job' do
    link = chef_run.link('/etc/init.d/exhibitor')
    expect(link).to link_to('/lib/init/upstart-job')
  end

  it 'enables and starts exhibitor' do
    expect(chef_run).to enable_service('exhibitor')
    expect(chef_run).to start_service('exhibitor')
  end
end
