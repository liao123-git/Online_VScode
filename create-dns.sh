#!/bin/bash
###
 # @Description: WASSUP
 # @Author: LDL <1923609016@qq.com>
 # @LastEditTime: 2024-04-12 22:15:45
 # @Date: 2024-04-11 20:06:06
 # @FilePath: \Online_VScode\create-dns.sh
### 

name=""
domain=""
editor=""
ip="124.222.128.49"

# 解析命令行参数
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -name) name="$2"; shift ;;
    -domain) domain="$2"; shift ;;
    -editor) editor="$2"; shift ;;
    -ip) ip="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

# 检查必需参数
if [ -z "$name" ] || [ -z "$editor" ] || [ -z "$domain" ] || [ -z "$ip" ]; then
  echo "Usage: $0 -name <name> -ip <local ipaddress> -domain <domain> -editor <editor domain>"
  exit 1
fi

echo ""
echo "------------set $name's coredns conf--------------"
sudo echo "
        $ip $domain
        $ip $editor
" > /editor/coredns/players/$name.conf

cat /editor/coredns/players/$name.conf
echo "------------end set $name's coredns conf--------------"
echo ""