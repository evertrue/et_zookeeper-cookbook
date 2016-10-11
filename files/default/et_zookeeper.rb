Ohai.plugin(:EtZookeeper) do
  provides 'et_zookeeper'

  collect_data do
    et_zookeeper Mash.new
  end
end
