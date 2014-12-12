Vagrant.configure("2") do |config|
 config.vm.define :node1 do |node1_config|
       node1_config.vm.box = "centos64"
       node1_config.vm.hostname = "node1"
       node1_config.vm.provider :virtualbox do |node1_vb|
               node1_vb.customize ["modifyvm", :id, "--cpus", "2", "--cpuexecutioncap", "50", "--memory", "1024", "--ioapic", "on"]
               #node1_vb.gui = true
       end
       node1_config.vm.network :private_network, ip: "192.168.90.2"
       node1_config.vm.network :forwarded_port, guest: 22, host: 1234
       node1_config.vm.network :forwarded_port, guest: 80, host: 8000 
       node1_config.vm.network :forwarded_port, guest: 8080, host: 8080 
       node1_config.vm.network :forwarded_port, guest: 9200, host: 9200 
       node1_config.vm.provision :puppet do |node1_puppet|
               #node1_puppet.pp_path = "/tmp/vagrant-puppet"
               node1_puppet.manifests_path = "manifests"
               node1_puppet.module_path = "modules"
               node1_puppet.hiera_config_path = "hiera.yaml"
               node1_puppet.manifest_file = "site.pp"
               node1_puppet.options = "--verbose"
       end
 end
 config.vm.define :node2 do |node2_config|
       node2_config.vm.box = "ubuntu_trusty"
       node2_config.vm.hostname = "node2"
       node2_config.vm.provider :virtualbox do |node2_vb|
               node2_vb.customize ["modifyvm", :id, "--cpus", "2", "--cpuexecutioncap", "50", "--memory", "1024", "--ioapic", "on"]
               #node1_vb.gui = true
       end
       node2_config.vm.network :private_network, ip: "192.168.90.3"
       node2_config.vm.network :forwarded_port, guest: 22, host: 1235
       node2_config.vm.network :forwarded_port, guest: 80, host: 8001 
       node2_config.vm.network :forwarded_port, guest: 8080, host: 8081 
       node2_config.vm.network :forwarded_port, guest: 9200, host: 9201 
       node2_config.vm.provision :puppet do |node2_puppet|
               node2_puppet.manifests_path = "manifests"
               node2_puppet.module_path = "modules"
               node2_puppet.hiera_config_path = "hiera.yaml"
               node2_puppet.working_directory = "/tmp/vagrant-puppet-2"
               node2_puppet.manifest_file = "site.pp"
               node2_puppet.options = "--verbose"
       end
 end
 config.vm.define :node3 do |node3_config|
       node3_config.vm.box = "centos64"
       node3_config.vm.hostname = "node3"
       node3_config.vm.provider :virtualbox do |node3_vb|
               node3_vb.customize ["modifyvm", :id, "--cpuexecutioncap", "80", "--memory", "512", "--ioapic", "on"]
               #node1_vb.gui = true
       end
       node3_config.vm.network :private_network, ip: "192.168.90.4"
       node3_config.vm.network :forwarded_port, guest: 22, host: 1236
       node3_config.vm.provision :puppet do |node3_puppet|
               node3_puppet.manifests_path = "manifests"
               node3_puppet.module_path = "modules"
               node3_puppet.hiera_config_path = "hiera.yaml"
               node3_puppet.manifest_file = "site.pp"
               node3_puppet.options = "--verbose"
               node3_puppet.hiera_config_path = "hiera.yaml"
       end
 end
end
