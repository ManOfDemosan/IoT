

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-22.04"
  
  user_name = "jaehwkim"
  
  config.vm.define "#{user_name}S" do |control|
    control.vm.hostname = "#{user_name}S"
    control.vm.network "private_network", ip: "192.168.56.110"
    
    control.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--name", "#{user_name}S"]
      v.gui = true
      v.memory = 1024
      v.cpus = 1
    end

    control.vm.provision "shell", inline: <<-SHELL
      curl -sfL https://get.k3s.io | sh -
    SHELL
  end

  config.vm.define "#{user_name}SW" do |control|
    control.vm.hostname = "#{user_name}SW"
    control.vm.network "private_network", ip: "192.168.56.111"
    
    control.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--name", "#{user_name}SW"]
      v.gui = true
      v.memory = 1024
      v.cpus = 1
    end

    control.vm.provision "shell", inline: <<-SHELL
      curl -sfL https://get.k3s.io | sh -
    SHELL
  end
end
