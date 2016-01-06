# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "trusty64"
  config.vm.box_url = "file://trusty64.box"
  config.vm.network "private_network", ip: "192.168.64.64"
  config.vm.synced_folder "./public", "/var/www", create: true, group: "www-data", owner: "www-data"
  config.vm.synced_folder "./conf", "/etc/nginx/sites-enabled"

  config.vm.provider "virtualbox" do |vb|
    vb.gui    = false
    vb.name   = "Vagrant"
    vb.memory = "2048"
  end

  config.vm.provision "shell", path: "./provision/setup.sh"
end
