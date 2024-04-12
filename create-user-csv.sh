#!/bin/bash
###
 # @Description: WASSUP
 # @Author: LDL <1923609016@qq.com>
 # @LastEditTime: 2024-04-12 10:40:25
 # @Date: 2024-04-11 18:51:46
 # @FilePath: \Online_VScode\create-users.sh
### 
num_of_people=0
prefix="player"
csv_file="output.csv"

# 解析命令行参数
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -num) num_of_people="$2"; shift ;;
    -prefix) prefix="$2"; shift ;;
    -csv) csv_file="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

echo "Name,Domain,Editor,Password" > "$csv_file"

# 生成人员数据并追加到 CSV 文件
for ((i=1; i<=num_of_people; i++))
do
  name="${prefix}${i}"
  domain="${name}.qgweb.com"
  editor="editor.${name}.qgweb.com"
  password=$(cat /dev/urandom | tr -dc 'A-KM-NP-Za-hj-z1-9&%' | fold -w 8 | head -n 1)
  
  echo "$name,$domain,$editor,$password" >> "$csv_file"
done

echo "CSV file generated: $csv_file"