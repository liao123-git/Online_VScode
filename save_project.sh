#!/bin/bash
###
 # @Description: WASSUP
 # @Author: LDL <1923609016@qq.com>
 # @LastEditTime: 2024-04-16 12:59:01
 # @Date: 2024-04-11 20:06:06
 # @FilePath: \Online_VScode\save_project.sh
### 

name=""
template_name=""

# 解析命令行参数
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -name) name="$2"; shift ;;
    -template) template_name="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

# 检查必需参数
if [ -z "$name" ] || [ -z "$template_name" ]; then
  echo "Usage: $0 -name <username> -template <template name>"
  exit 1
fi

  echo ""
  echo "------------copy $name's project to $template_name--------------"
  sudo cp -rf /editor/players/$name/ /editor/template/$template_name
  echo "------------end copy $name's project to $template_name--------------"
  echo ""
