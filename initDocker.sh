sudo apt update
sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt install docker-ce docker-ce-cli containerd.io
sudo systemctl status docker
sudo apt-mark hold docker-ce

sudo docker pull tomsik68/xampp:8
sudo docker pull codercom/code-server
sudo docker pull nginx
sudo docker pull coredns/coredns


