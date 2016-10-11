ruby_block 'test myid' do
  block { raise 'no myid!' unless node['et_zookeeper']['myid'] }
end
