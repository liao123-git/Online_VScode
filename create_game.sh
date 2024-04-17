#!/bin/bash
###
 # @Description: WASSUP
 # @Author: LDL <1923609016@qq.com>
 # @LastEditTime: 2024-04-16 16:08:58
 # @Date: 2024-04-11 16:10:20
 # @FilePath: \Online_VScode\create_game.sh
### 

# 设置默认参数
num_of_people=0
prefix="player"
csv_file="output.csv"
ip=""
template="default"

# 解析命令行参数
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -num) num_of_people="$2"; shift ;;
    -prefix) prefix="$2"; shift ;;
    -csv) csv_file="$2.csv"; shift ;;
    -ip) ip="$2"; shift ;;
    -template) template="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

# 检查必需参数
if [ "$num_of_people" -eq 0 ]; then
  echo "Usage: $0 -num <num_of_people> -ip <ip>"
  exit 1
fi

if ! [ -z "$ip" ]; then
    ./set_ip.sh -ip $ip
fi

./clear_csv.sh -csv $csv_file

./create_user_csv.sh -num $num_of_people -prefix $prefix -csv $csv_file
./create_xampp_csv.sh -csv $csv_file
./create_editor_csv.sh -csv $csv_file
./create_nginx_csv.sh -csv $csv_file
./create_dns_csv.sh -csv $csv_file
./install_extension_csv.sh -csv $csv_file -v normal
./set_template_csv.sh -csv $csv_file -template $template
sudo chmod -R 777 /editor

cat $csv_file