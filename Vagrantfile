# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

current_dir    = File.dirname(File.expand_path(__FILE__))
configs        = YAML.load_file("#{current_dir}/config.yaml")
vagrant_config = configs['configs']

ENV['VAGRANT_DEFAULT_PROVIDER'] = "virtualbox"

Vagrant.configure("2") do |config|
  config.vm.define "lamp-ubuntu-22"
  config.vm.hostname = "lamp-ubuntu-22"
  config.vm.box = "bento/ubuntu-22.04"
  config.vm.box_version = "202303.13.0"
  
  config.vm.network "private_network", ip: vagrant_config['private_ip']

  config.vm.synced_folder "./www/html", "/var/www/html" 

  config.vm.provision :shell, path: "./provision/components/apache2.sh"
  config.vm.provision :shell, path: "./provision/components/php.sh"
  config.vm.provision "shell" do |s|
    s.inline = "/bin/sh /vagrant/provision/components/mysql.sh $1 $2 $3"
    s.args   = [ vagrant_config['dbname'], vagrant_config['dbuser'], vagrant_config['dbpassword'] ]
  end
  config.vm.provision "shell" do |s|
    s.inline = "/bin/sh /vagrant/provision/components/post-apache2.sh $1 $2"
    s.args   = [ vagrant_config['server_name'], vagrant_config['server_alias'] ]
  end

end
