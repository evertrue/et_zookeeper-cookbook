require 'spec_helper'

describe 'et_zookeeper::default' do
  describe service 'zookeeper' do
    it { is_expected.to be_running.under('runit') }

    # Disabled until my pull request (https://github.com/mizzy/serverspec/pull/581) is merged
    # it { is_expected.to be_enabled.under('runit') }
  end

  describe port 21_801 do
    it { is_expected.to be_listening.with 'tcp6' }
  end

  describe 'Zookeeper config' do
    describe file '/opt/zookeeper/conf/zookeeper-env.sh' do
      it { should be_file }
      its(:content) { should include 'export ZOO_LOG_DIR=/mnt/dev0/zookeeper/logs' }
      its(:content) { should include 'export ZOO_LOG4J_PROP=INFO,ROLLINGFILE' }
    end

    describe file '/opt/zookeeper/conf/zoo.cfg' do
      its(:content) { should include 'server.6=zk1:2888:3888' }
      its(:content) { should include 'server.11=zk2:2888:3888' }
      its(:content) { should contain /server\..*=default-ubuntu-1404:2888:3888/ }
    end
  end

  describe 'Datadog Agent' do
    describe file '/etc/dd-agent/conf.d/zookeeper.yaml' do
      it { is_expected.to be_file }
    end
  end

  describe 'filebeat prospector' do
    describe file '/etc/filebeat/conf.d/prospector-zookeeper.yml' do
      it { is_expected.to be_file }
      its(:content) { should include '---
filebeat:
  prospectors:
  - paths:
    - "/mnt/dev0/zookeeper/logs/zookeeper.log"
    document_type: zookeeper
    input_type: log' }
    end
  end
end
