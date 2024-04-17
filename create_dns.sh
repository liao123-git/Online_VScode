#!/bin/bash
###
 # @Description: WASSUP
 # @Author: LDL <1923609016@qq.com>
 # @LastEditTime: 2024-04-16 19:40:21
 # @Date: 2024-04-11 20:06:06
 # @FilePath: \Online_VScode\create_dns.sh
### 

name=""
domain=""
editor=""

# 解析命令行参数
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -name) name="$2"; shift ;;
    -domain) domain="$2"; shift ;;
    -editor) editor="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

# 检查必需参数
if [ -z "$name" ] || [ -z "$editor" ] || [ -z "$domain" ]; then
  echo "Usage: $0 -name <name> -domain <domain> -editor <editor domain>"
  exit 1
fi

echo ""
echo "------------set $name's coredns conf--------------"
sudo echo "
        $STATIC_IP $domain
        $STATIC_IP $editor
" > /editor/coredns/players/$name.conf

cat /editor/coredns/players/$name.conf
echo "------------end set $name's coredns conf--------------"
echo ""
