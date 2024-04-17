#!/bin/bash

name=""

# 解析命令行参数
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -name) name="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

# 检查必需参数
if [ -z "$name" ]; then
  echo "Usage: $0 -name <name>"
  exit 1
fi


  sudo echo ""
  sudo echo "--------------------clear $name------------------"

  sudo rm -rf /editor/players/$name
  sudo rm -rf /editor/players/$name
  sudo rm -rf /editor/coredns/players/$name
  sudo rm -rf ./$name.csv
  sudo docker rm -f ${name}_xampp
  sudo docker rm -f ${name}_editor
  sudo docker exec -i nginx rm -f /etc/nginx/conf.d/$name.conf
  sudo chmod -R 777 /editor

  sudo echo "--------------------end clear $name------------------"
  sudo echo ""