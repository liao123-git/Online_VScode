#!/bin/bash
###
 # @Description: WASSUP
 # @Author: LDL <1923609016@qq.com>
 # @LastEditTime: 2024-04-16 14:23:56
 # @Date: 2024-04-15 13:58:02
 # @FilePath: \Online_VScode\set_ip.sh
### 

# 设置静态 IP 地址
ip=""
gateway=""
netmask="24"
interface="ens33"
file="00-installer"

# 解析命令行参数
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -ip) ip="$2"; shift ;;
    -file) file="$2"; shift ;;
    -gateway) gateway="$2"; shift ;;
    -netmask) netmask="$2"; shift ;;
    -interface) interface="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

# 检查必需参数
if [ -z "$ip" ] || [ -z "$gateway" ] || [ -z "$interface" ]; then
  echo "Usage: $0 -ip <ip address> -gateway <gateway> -interface<interface>"
  exit 1
fi

# 将静态 IP 存储为系统环境变量
echo "STATIC_IP=$ip" | sudo tee -a /etc/environment

# 备份原始的网络配置文件
sudo cp /etc/netplan/$file-config.yaml /etc/netplan/$file-config.yaml.bak
# 创建新的网络配置文件
sudo tee /etc/netplan/$file-config.yaml > /dev/null <<EOT
network:
  ethernets:
    $interface:
      dhcp4: no
      dhcp6: no
      addresses: 
        - $ip/$netmask
      routes:
        - to: 0.0.0.0/0
          via: $gateway
      nameservers:
        addresses: 
          - 127.0.0.1
          - 8.8.8.8
  version: 2
  renderer: networkd
EOT

# 重新加载环境变量
source /etc/environment
sudo systemctl restart systemd-networkd
sudo netplan apply

sudo ip a