#!/bin/bash
###
 # @Description: WASSUP
 # @Author: LDL <1923609016@qq.com>
 # @LastEditTime: 2024-04-14 22:20:37
 # @Date: 2024-04-11 16:10:20
 # @FilePath: \Online_VScode\create_game.sh
### 

# 设置默认参数
num_of_people=0
prefix="player"
csv_file="output.csv"
ip="124.222.128.49"

# 解析命令行参数
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -num) num_of_people="$2"; shift ;;
    -prefix) prefix="$2"; shift ;;
    -csv) csv_file="$2.csv"; shift ;;
    -ip) ip="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

# 检查必需参数
if [ "$num_of_people" -eq 0 ]; then
  echo "Usage: $0 -num <num_of_people>"
  exit 1
fi

./create_file.sh
./clear_csv -csv $csv_file

./create_user_csv.sh -num $num_of_people -prefix $prefix -csv $csv_file
./create_xampp_csv.sh -csv $csv_file
./create_editor_csv.sh -csv $csv_file
./create_nginx_csv.sh -csv $csv_file
./create_dns_csv.sh -csv $csv_file -ip $ip
./install_extension_csv.sh -csv $csv_file -v normal

cat $csv_file