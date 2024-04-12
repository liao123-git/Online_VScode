sudo rm -rf /editor/players/*
sudo mkdir -p /editor/players
cd /editor

echo ""
echo "------------clear docker containers--------------"
sudo docker rm -f $(docker ps -aq) 
echo "------------end clear player editors--------------"
echo ""
