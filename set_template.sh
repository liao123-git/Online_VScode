#!/bin/bash
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

echo ""
echo "-----------------------set $name's template---------------------------------"

  sudo rm -rf /editor/players/$name
  sudo cp -rf /editor/template/$template/ /editor/players/$name
  sudo docker restart ${name}_editor
  sudo docker restart ${name}_xampp

echo "-----------------------end set $name's template---------------------------------"
echo ""