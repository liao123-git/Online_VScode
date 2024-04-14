###
 # @Description: WASSUP
 # @Author: LDL <1923609016@qq.com>
 # @LastEditTime: 2024-04-14 19:24:07
 # @Date: 2024-04-14 18:33:32
 # @FilePath: \Online_VScode\create_file.sh
### 
sudo rm -rf /editor/players/*
sudo mkdir -p /editor/players
sudo rm -rf /editor/coredns/*
sudo mkdir -p /editor/coredns/players

sudo echo '.:53 {
    forward . 114.114.114.114 8.8.8.8
    log
    errors
}
' > /editor/coredns/Corefile