require 'spec_helper'

describe 'Exhibitor Service' do
  describe file '/opt/exhibitor/exhibitor.s3.properties' do
    it { should be_file }
    its(:content) { should include 'FAKE_ACCESS_KEY' }
    its(:content) { should include 'FAKE_SECRET_KEY' }
  end

  describe file '/opt/exhibitor/exhibitor.properties' do
    it { should be_file }
    its(:content) do
      should include(
        'zoo-cfg-extra=tickTime\=2000&initLimit\=11&syncLimit\=17' \
        '&autopurge.snapRetainCount\=20&autopurge.purgeInterval\=1'
      )
    end
  end

  describe file '/etc/sv/exhibitor/run' do
    it { should be_file }
    its(:content) { should include '--configtype s3' }
    its(:content) { should include '--s3config ops.evertrue.com:zookeeper-' }
    its(:content) { should include '--s3credentials /opt/exhibitor/exhibitor.s3.properties' }
    its(:content) { should include '--s3region us-east-1' }
  end

  describe port '8080' do
    it { should be_listening }
  end

  describe service 'exhibitor' do
    it { should be_running }
  end
end
