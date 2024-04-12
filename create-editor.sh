#!/bin/bash
###
 # @Description: WASSUP
 # @Author: LDL <1923609016@qq.com>
 # @LastEditTime: 2024-04-12 22:16:27
 # @Date: 2024-04-11 20:06:06
 # @FilePath: \Online_VScode\create-editor.sh
### 

name=""
password=""

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
if [ -z "$name" ] || [ -z "$password" ]; then
  echo "Usage: $0 -name <username> -pass <password>"
  exit 1
fi

  echo "------------create $name's editor--------------"
  sudo docker container rm -f ${name}_editor
  sudo docker run -d -it --name ${name}_editor --net game \
            -v "/editor/players/$name/.config:/home/coder/.config" \
            -v "/editor/players/$name/project:/home/coder/project" \
            -u "$(id -u):$(id -g)" \
            -e "PASSWORD"=$password \
            codercom/code-server:latest
  echo "------------end create $name's editor--------------"
  echo ""
