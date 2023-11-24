Vagrant.configure("2") do |config|
  # 공통 설정
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.box_url = "https://vagrantcloud.com/bento/boxes/ubuntu-16.04/versions/202212.11.0/providers/virtualbox/unknown/vagrant.box"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 512
    vb.cpus = 1
  end

  # 컨트롤러 가상 머신 설정
  config.vm.define "jaehwkimS" do |ctl|
    ctl.vm.hostname = "jaehwkimS"
    ctl.vm.network "private_network", ip: "192.168.56.110"
    ctl.vm.provider "virtualbox" do |vb|
      vb.name = "jaehwkimS"
    end
    # 서버 설정 스크립트 실행
    ctl.vm.provision "shell", inline: <<-SHELL
    # k3s 설치
    curl -sfL https://get.k3s.io | sh -s - --node-ip 192.168.56.110 --advertise-address 192.168.56.110 --flannel-iface eth1 --write-kubeconfig-mode 644

    # 컨트롤러 노드에서 생성된 인증 토큰을 복사 
    cp /var/lib/rancher/k3s/server/node-token /vagrant/server-node-token

    # k alias 
    echo "alias k='kubectl'" >> /home/vagrant/.bashrc
  SHELL
  end

  # 워커 가상 머신 설정
  config.vm.define "jaehwkimSW" do |wrk|
    wrk.vm.hostname = "jaehwkimSW"
    wrk.vm.network "private_network", ip: "192.168.56.111"
    wrk.vm.provider "virtualbox" do |vb|
      vb.name = "jaehwkimSW"
    end
    # 에이전트 설정 스크립트 실행
    wrk.vm.provision "shell", inline: <<-SHELL
    # k3s 설치
    curl -sfL https://get.k3s.io | sh -s - agent --server https://192.168.56.110:6443 --node-ip 192.168.56.111 --token-file /vagrant/server-node-token --flannel-iface eth1

    # 컨트롤러 노드에 연결 후 필요없으니 삭제
    rm /vagrant/server-node-token
  SHELL
  end
end
