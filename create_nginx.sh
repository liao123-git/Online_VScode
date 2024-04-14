#!/bin/bash
###
 # @Description: WASSUP
 # @Author: LDL <1923609016@qq.com>
 # @LastEditTime: 2024-04-12 22:04:48
 # @Date: 2024-04-11 20:06:06
 # @FilePath: \Online_VScode\create-nginx.sh
### 

# 指定 CSV 文件路径
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
if [ -z "$name" ] ||  [ -z "$editor" ] || [ -z "$domain" ]; then
  echo "Usage: $0 -name <name> -domain <domain> -editor <editor domain>"
  exit 1
fi

  echo ""
  echo "------------set $name's nginx conf--------------"
    sudo docker exec -i nginx bash -c "echo 'server {
        listen 80;
        server_name '$domain';

        location / {
            proxy_pass http://'$name'_xampp:80;
            proxy_set_header Host \$host;
            proxy_set_header Upgrade \$http_upgrade;
            proxy_set_header Connection upgrade;
            proxy_set_header Accept-Encoding gzip;
        }
    }' > /etc/nginx/conf.d/$name.conf"

    sudo docker exec -i nginx bash -c "echo 'server {
        listen 80;
        server_name '$editor';

        location / {
            proxy_pass http://'$name'_editor:8080;
            proxy_set_header Host \$host;
            proxy_set_header Upgrade \$http_upgrade;
            proxy_set_header Connection upgrade;
            proxy_set_header Accept-Encoding gzip;
        }
    }' >> /etc/nginx/conf.d/$name.conf"
    sudo docker exec -i nginx cat /etc/nginx/conf.d/$name.conf

    sudo docker exec -i nginx nginx -t
    sudo docker exec -i nginx nginx -s reload
  echo "------------end set $name's nginx conf--------------"
  echo ""

