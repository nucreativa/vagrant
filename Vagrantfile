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

  # set auto_update to false, if you do NOT want to check the correct 
  # additions version when booting this machine
  config.vbguest.auto_update = false

  # do NOT download the iso file from a webserver
  config.vbguest.no_remote = true

  config.vm.provision "shell", path: "./provision/setup.sh"
end
