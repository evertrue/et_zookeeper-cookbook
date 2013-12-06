# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  case ENV["VAGRANT_DEFAULT_PROVIDER"]
  when "aws"

    config.vm.box = "dummy"
    config.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"

    config.vm.provider :aws do |aws, override|
      aws.access_key_id = "#{ENV['AWS_ACCESS_KEY']}"
      aws.secret_access_key = "#{ENV['AWS_SECRET_KEY']}"
      aws.keypair_name = "aws_dev"
      #aws.private_ip_address = "10.0.0.165"

      aws.ami = "ami-cf5e2ba6"

      aws.security_groups = ["sg-79ea5a16"]
      aws.subnet_id = "subnet-d97dcfb2"
      aws.tags = {
        "Name" => "stage-et-zookeeper-#{config.vm.hostname}",
        "Role" => "et_base Testing",
        "Env" => "stage"
      }
      aws.elastic_ip = true

      override.ssh.username = "ubuntu"
      override.ssh.private_key_path = "#{ENV['HOME']}/.ssh/aws_dev.pem"
      #override.ssh.host = "10.0.0.165"
    end

    config.vm.provision :shell, :inline => "mkdir -p /etc/chef/ohai/hints && echo '{}' > /etc/chef/ohai/hints/ec2.json"

  else

    config.vm.provider "virtualbox" do |v|
      v.customize ['modifyvm', :id, "--memory", "1024"]

      # We want to replicate the environment on ec2 where initial provisions
      # have to work WITHOUT being able to resolve our own name on the local
      # DNS server
      v.customize ['setextradata', :id, "VBoxInternal/Devices/{pcnet,e1000}/0/LUN#0/Config/HostResolverMappings/ et-zookeeper-berkshelf/HostIP", ""]
    end

    # Every Vagrant virtual environment requires a box to build off of.
    config.vm.box = "precise64"

    # The url from where the 'config.vm.box' box will be fetched if it
    # doesn't already exist on the user's system.
    config.vm.box_url = "http://cloud-images.ubuntu.com/precise/current/precise-server-cloudimg-vagrant-amd64-disk1.box"

  end

  config.vm.hostname = "et-zookeeper-berkshelf"

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :private_network, ip: "33.33.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.

  # config.vm.network :public_network

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # The path to the Berksfile to use with Vagrant Berkshelf
  # config.berkshelf.berksfile_path = "./Berksfile"

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to exclusively install and copy to Vagrant's shelf.
  # config.berkshelf.only = []

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.except = []

  #config.vm.synced_folder "vagrantsync/", "/vagrantsync"

  if ENV['CHEF_REPO']
    chef_repo = ENV['CHEF_REPO']
  else
    raise "CHEF_REPO is not defined"
  end

  config.vm.synced_folder "#{ENV['HOME']}/.chef", "/tmp/local-chef"

  case ENV["VAGRANT_DEFAULT_PROVIDER"]
  when "aws"

    config.vm.provision :shell, :inline => "curl -s -L https://www.opscode.com/chef/install.sh | sudo bash"

    config.chef_zero.chef_repo_path = ".chef-zero/"

    config.vm.provision :chef_solo do |chef|
      chef.json = {
        'test_run' => true
      }
      #chef.encrypted_data_bag_secret = "/tmp/local-chef/encrypted_data_bag_secret"
      #chef.environment = "stage"
      chef.data_bags_path = "#{chef_repo}/data_bags"
      chef.encrypted_data_bag_secret_key_path = "#{ENV['HOME']}/.chef/encrypted_data_bag_secret"
      chef.node_name = "et-zookeeper-berkshelf"
      chef.log_level = :debug
      chef.cookbooks_path = "#{ENV['HOME']}/git_repos/evertrue/cookbooks"
      chef.run_list = [
        "recipe[et_zookeeper::default]"
      ]
    end

  else
    config.vm.provision :shell, :inline => "sudo apt-get purge -y ruby1.8 ruby1.8-dev libaugeas0 augeas-lenses libruby libshadow-ruby1.8 libruby1.8 rubygems1.8 binutils build-essential cpp cpp-4.6 dpkg-dev fakeroot g++ g++-4.6 gcc gcc-4.6 libalgorithm-diff-perl libalgorithm-diff-xs-perl libalgorithm-merge-perl libc-dev-bin libc6-dev libdpkg-perl libgomp1 libmpc2 libmpfr4 libquadmath0 libstdc++6-4.6-dev linux-libc-dev make manpages-dev"

    config.omnibus.chef_version = :latest

    config.chef_zero.chef_repo_path = ".chef-zero/"

    config.vm.provision :shell, :inline => "mkdir -p /mnt/elasticsearch"

    config.vm.provision :chef_client do |chef|

      chef.json = {
        "ec2" => {
          "block_device_mapping_ephemeral0" => "sda2"
        },
        "filesystem" => {
          "/dev/xvda2" => {
            "mount" => "/mnt"
          }
        }
      }

      chef.encrypted_data_bag_secret = "/tmp/local-chef/encrypted_data_bag_secret"
      chef.environment = "stage"
      chef.log_level = "info"

      chef.run_list = [
          "recipe[et_zookeeper::default]"
      ]
    end
  end
end
