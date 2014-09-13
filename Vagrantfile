require 'yaml'

Vagrant.configure("2") do |config|
  
  # Box
  config.vm.box = "ubuntu-14.04"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  # Sites disponiveis
  sites = YAML.load(File.open("sites.yml"))
  
  # Pattern 
  patterns = []

  sites.each do |key,value| 
    
    # Configura porta para site
    config.vm.network "forwarded_port", guest: value[:port], host: value[:port]

    # Configura diretorio
    config.vm.synced_folder value[:folder], "/var/www/#{value[:virtualfolder]}", 
      owner: "vagrant", 
      group: "www-data", 
      mount_options: ["dmode=777,fmode=664"]

    # Expressoes para dns
    pattern = "^.*#{key.to_s}.dev$"
    patterns << (Regexp.new pattern)
  end
  
  # DNS 
  config.dns.tld = "dev"
  config.vm.hostname = "machine"
  config.dns.patterns = patterns

  # MySQL
  config.vm.network "forwarded_port", guest: 3306, host: 3303

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "33.33.33.60"

  # Puppet
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'puppet/manifests'
    puppet.module_path = 'puppet/modules'
    puppet.manifest_file = 'init.pp'
  end
end
