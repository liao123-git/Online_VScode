#!/bin/bash
###
 # @Description: WASSUP
 # @Author: LDL <1923609016@qq.com>
 # @LastEditTime: 2024-04-17 10:15:51
 # @Date: 2024-04-11 16:07:50
 # @FilePath: \Online_VScode\init.sh
### 

sudo cp /etc/resolv.conf /etc/resolv.conf.bak
sudo sed -i 's/nameserver 127.0.0.53/nameserver 8.8.8.8/' /etc/resolv.conf
sudo sed -i 's/nameserver 127.0.0.1/nameserver 8.8.8.8/' /etc/resolv.conf
sudo ufw disable
sudo systemctl restart systemd-networkd

echo ""
echo "------------------------------install need program------------------------------"
sudo yes | apt update
sudo yes | apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
sudo set -eo pipefail
# 导入 Docker 官方 GPG 密钥
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o docker-archive-keyring.gpg
# 创建并移动到 trusted.gpg.d 目录
sudo mkdir -p /etc/apt/trusted.gpg.d
sudo mv docker-archive-keyring.gpg /etc/apt/trusted.gpg.d/docker-archive-keyring.gpg
sudo yes | add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo yes | apt install docker-ce docker-ce-cli containerd.io
sudo yes | apt-mark hold docker-ce
sudo yes | apt-get install linux-modules-extra-raspi
sudo yes | apt-get install openvswitch-switch-dpdk
echo "------------------------------install need program------------------------------"
echo ""

# 备份 Docker daemon 配置文件
sudo cp /etc/docker/daemon.json /etc/docker/daemon.json.bak
# 编辑 Docker daemon 配置文件
sudo tee /etc/docker/daemon.json > /dev/null <<EOT
{
  "registry-mirrors": ["https://cn-shanghai.mirror.aliyuncs.com"]
}
EOT

echo ""
echo "------------------------------pull docker images------------------------------"
sudo systemctl restart docker
sudo docker pull tomsik68/xampp:8
sudo docker pull codercom/code-server:4.23.0
sudo docker pull nginx:stable
sudo docker pull coredns/coredns:1.11.1
sudo docker image ls
echo "------------------------------pull docker images-------------------------------"
echo ""

# 安装完成停了本机的 dns nginx 服务
sudo systemctl stop nginx
sudo systemctl stop systemd-resolved
sudo docker network create game

./init_docker.sh

sudo mkdir -p /editor/template/default/project
sudo mkdir -p /editor/template/default/.config

sudo sed -i 's/nameserver 8.8.8.8/nameserver 127.0.0.1/' /etc/resolv.conf
sudo sed -i 's/nameserver 127.0.0.53/nameserver 127.0.0.1/' /etc/resolv.conf
sudo systemctl restart systemd-networkd