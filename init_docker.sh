#!/bin/bash
./create_file.sh

echo ""
echo "------------clear docker containers--------------"
sudo docker rm -f $(docker ps -aq) 
echo "------------end clear player editors--------------"
echo ""

sudo docker run -d --name nginx -p 80:80 --net game nginx:stable
sudo docker run -d --name coredns -p 53:53/udp -v /editor/coredns:/etc/coredns --net game coredns/coredns:1.11.1 -conf /etc/coredns/Corefile
