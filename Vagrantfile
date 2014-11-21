# -*- mode: ruby -*-
# vi: set ft=ruby :
 
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "precise64"
    config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  
    config.vm.define "shard01" do |shard01| 
        shard01.vm.host_name = "shard01"
        shard01.vm.network "private_network", ip: "10.0.0.11"    

        shard01.vm.provision "shell", path: "scripts/shard.sh"
        shard01.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--memory", "1024"]
            v.customize ["modifyvm", :id, "--cpus", "1"]
        end
    end

    config.vm.define "shard02" do |shard02| 
        shard02.vm.host_name = "shard02"
        shard02.vm.network "private_network", ip: "10.0.0.12"    

        shard02.vm.provision "shell", path: "scripts/shard.sh"
        shard02.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--memory", "1024"]
            v.customize ["modifyvm", :id, "--cpus", "1"]
        end
    end

    config.vm.define "shard03" do |shard03| 
        shard03.vm.host_name = "shard03"
        shard03.vm.network "private_network", ip: "10.0.0.13"    

        shard03.vm.provision "shell", path: "scripts/shard.sh"
        shard03.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--memory", "1024"]
            v.customize ["modifyvm", :id, "--cpus", "1"]
        end
    end

    config.vm.define "config01" do |config01| 
        config01.vm.host_name = "config01"
        config01.vm.network "private_network", ip: "10.0.0.15"    

        config01.vm.provision "shell", path: "scripts/config_server.sh"
        config01.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--memory", "1024"]
            v.customize ["modifyvm", :id, "--cpus", "1"]
        end
    end

    config.vm.define "query01" do |query01| 
        query01.vm.host_name = "query01"
        query01.vm.network "private_network", ip: "10.0.0.14"    

        query01.vm.provision "shell", path: "scripts/query_server.sh"
        query01.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--memory", "1024"]
            v.customize ["modifyvm", :id, "--cpus", "1"]
        end
    end

end
