#!/bin/bash
###
 # @Description: WASSUP
 # @Author: LDL <1923609016@qq.com>
 # @LastEditTime: 2024-04-14 18:25:20
 # @Date: 2024-04-11 20:06:06
 # @FilePath: \Online_VScode\create-nginx-csv.sh
### 

# 指定 CSV 文件路径
csv_file="output.csv"

# 解析命令行参数
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -csv) csv_file="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

# 检查 CSV 文件是否存在
if [ ! -f "$csv_file" ]; then
  echo "CSV file not found: $csv_file"
  exit 1
fi

while IFS= read -r line <&3
do
  # 跳过标题行
  if [[ $line == "Name,Domain,Editor,Password" ]]; then
    continue
  fi

  # 分割行为数组
  IFS=',' read -r -a values <<< "$line"

  name=${values[0]}
  domain=${values[1]}
  editor=${values[2]}

  ./create_nginx.sh -name $name -domain $domain -editor $editor

done 3< "$csv_file"