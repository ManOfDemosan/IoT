#!/bin/bash

# k3s 설치
curl -sfL https://get.k3s.io | sh -s - --node-ip 192.168.56.110 --advertise-address 192.168.56.110 --flannel-iface eth1 --write-kubeconfig-mode 644

# k alias 
echo "alias k='kubectl'" >> /home/vagrant/.bashrc

# gui 환경설정
sudo apt-get update
sudo apt-get install -y ubuntu-desktop
sudo apt-get install -y firefox

# 도메인을 IP 주소에 매핑
echo "192.168.56.110 app1.com" | sudo tee -a /etc/hosts
echo "192.168.56.110 app2.com" | sudo tee -a /etc/hosts

# YAML 파일들을 적용
kubectl apply -f /home/vagrant/app1-deployment-service.yaml
kubectl apply -f /home/vagrant/app2-deployment-service.yaml
kubectl apply -f /home/vagrant/app3-deployment-service.yaml
kubectl apply -f /home/vagrant/ingress.yaml
