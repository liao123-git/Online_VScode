#!/bin/bash
###
 # @Description: WASSUP
 # @Author: LDL <1923609016@qq.com>
 # @LastEditTime: 2024-04-12 22:00:33
 # @Date: 2024-04-11 20:06:06
 # @FilePath: \Online_VScode\create-xampp.sh
### 

name=""

# 解析命令行参数
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -name) name="$2"; shift ;;
    -pass) password="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

# 检查必需参数
if [ -z "$name" ]; then
  echo "Usage: $0 -name <username>"
  exit 1
fi

  echo ""
  echo "------------create $name's xampp--------------"
    sudo docker container rm -f ${name}_xampp
    docker run --name ${name}_xampp -d \
                -v /editor/players/$name/project:/opt/lampp/htdocs --net game \
                tomsik68/xampp:8
  echo "------------end create $name's xampp--------------"
  echo ""
