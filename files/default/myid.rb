Ohai.plugin(:Myid) do
  provides 'et_zookeeper/myid'
  depends 'et_zookeeper'

  collect_data do
    myid_path = nil
    %w(
      /mnt/zookeeper
      /mnt/dev0/zookeeper
      /mnt/zookeeper/data
    ).each { |path| if File.exist?("#{path}/myid"); myid_path = path; end }
    et_zookeeper[:myid] = File.read("#{myid_path}/myid").strip
  end
end
