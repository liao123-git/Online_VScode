sudo cp /etc/resolv.conf /etc/resolv.conf.bak
sudo sed -i 's/nameserver 127.0.0.53/nameserver 8.8.8.8/' /etc/resolv.conf
sudo ufw disable
sudo systemctl restart systemd-networkd

sudo yes | apt update
sudo yes | apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
sudo yes | curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo yes | add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo yes | apt install docker-ce docker-ce-cli containerd.io
sudo yes | apt-mark hold docker-ce

sudo docker pull tomsik68/xampp:8
sudo docker pull codercom/code-server:4.23.0-39
sudo docker pull nginx:stable
sudo docker pull coredns/coredns:1.11.1

# 安装完成停了本机的 dns nginx 服务
sudo systemctl stop nginx
sudo systemctl stop systemd-resolved
sudo docker network create game

./init_docker.sh

sudo sed -i 's/nameserver 8.8.8.8/nameserver 127.0.0.1/' /etc/resolv.conf
sudo systemctl restart systemd-networkd