require 'spec_helper'

describe 'et_zookeeper::default' do
  describe service 'zookeeper' do
    it { is_expected.to be_running.under('runit') }

    # Disabled until my pull request (https://github.com/mizzy/serverspec/pull/581) is merged
    # it { is_expected.to be_enabled.under('runit') }
  end

  describe 'Zookeeper config' do
    describe file '/opt/zookeeper/conf/zookeeper-env.sh' do
      it { should be_file }
      its(:content) { should include 'export ZOO_LOG_DIR=/mnt/zookeeper/logs' }
      its(:content) { should include 'export ZOO_LOG4J_PROP=INFO,ROLLINGFILE' }
    end
  end

  describe 'Datadog Agent' do
    describe file '/etc/dd-agent/conf.d/zookeeper.yaml' do
      it { is_expected.to be_file }
    end
  end
end
