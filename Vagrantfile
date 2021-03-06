require 'yaml'

Vagrant.configure("2") do |config|
  
  # Box
  config.vm.box = "ubuntu-package"

  # Sites disponiveis
  sites = YAML.load(File.open("sites.yml"))
  
  # Pattern 
  patterns = []

  # Configura diretorio
  config.vm.synced_folder "/Users/thiago/Sites/", "/var/www/", 
    owner: "vagrant", 
    group: "www-data", 
    mount_options: ["dmode=777,fmode=777"]

  sites.each do |key,value| 
    
    # Configura porta para site
    config.vm.network "forwarded_port", guest: value[:port], host: value[:port]

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

  # Mailcatcher
  config.vm.network "forwarded_port", guest: 1080, host: 1080
  config.vm.network "forwarded_port", guest: 1025, host: 1025

  # Jekyll
  config.vm.network "forwarded_port", guest: 4000, host: 4000

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "33.33.33.60"

  # Puppet
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'puppet/manifests'
    puppet.module_path = 'puppet/modules'
    puppet.manifest_file = 'init.pp'
  end

  # Otimization
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
    v.customize ["modifyvm", :id, "--ioapic", "on"]
  end
end

## TODO
# * Pre-instalar: RVM, Ruby On Rails, Phalcon PHP
