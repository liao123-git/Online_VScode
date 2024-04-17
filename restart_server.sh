#!/bin/bash
echo ""
echo "------------restart docker containers--------------"
sudo docker restart $(docker ps -aq) 
echo "------------end restart docker containers--------------"
echo ""