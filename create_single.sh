#!/bin/bash
###
 # @Description: WASSUP
 # @Author: LDL <1923609016@qq.com>
 # @LastEditTime: 2024-04-16 18:33:39
 # @Date: 2024-04-12 21:37:10
 # @FilePath: \Online_VScode\create_single.sh
### 

# 设置默认参数
name=""
template="default"

# 解析命令行参数
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -name) name="$2"; shift ;;
    -template) template="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

# 检查必需参数
if [ -z "$name" ]; then
  echo "Usage: $0 -name <username>"
  exit 1
fi

password=$(cat /dev/urandom | tr -dc 'A-KM-NP-Za-hj-z1-9&%' | fold -w 8 | head -n 1)
domain="${name}.qgweb.com"
editor="editor.${name}.qgweb.com"

./create_xampp.sh -name $name
./create_editor.sh -name $name -pass $password
./create_nginx.sh -name $name -domain $domain -editor $editor
./create_dns.sh -name $name -domain $domain -editor $editor
./reset_dns.sh -path /editor/coredns/players
./install_extension.sh -name $name
./set_template.sh -name $name -template $template

csv_file="$name.csv"
echo "Name,Domain,Editor,Password" > "$csv_file"
echo "$name,$domain,$editor,$password" >> "$csv_file"
cat "$name.csv"
