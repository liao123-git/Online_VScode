#!/bin/bash
###
 # @Description: WASSUP
 # @Author: LDL <1923609016@qq.com>
 # @LastEditTime: 2024-04-12 14:49:24
 # @Date: 2024-04-11 18:51:46
 # @FilePath: \Online_VScode\create-user.sh
### 
name=""
password=$(cat /dev/urandom | tr -dc 'A-KM-NP-Za-hj-z1-9&%' | fold -w 8 | head -n 1)
file_path=""

# 解析命令行参数
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -name) name="$2"; shift ;;
    -pass) password="$2"; shift ;;
    -path) file_path="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

# 检查必需参数
if [ -z "$name" ]; then
  echo "Usage: $0 -name <username> -pass <password>"
  exit 1
fi

domain="${name}.qgweb.com"
editor="editor.${name}.qgweb.com"

sudo rm -rf /editor/players/$name
sudo mkdir -p /editor/players/$name/.config 
sudo mkdir -p /editor/players/$name/project 
sudo chmod -R 777 /editor/players/$name/*

./create-xampp.sh -name $name
./create-editor.sh -name $name -pass $pasword

echo "$name,$domain,$editor,$password" >> "$name.info"


