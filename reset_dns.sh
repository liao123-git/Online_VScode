# /usr/sh
###
 # @Description: WASSUP
 # @Author: LDL <1923609016@qq.com>
 # @LastEditTime: 2024-04-16 14:34:06
 # @Date: 2024-04-12 10:06:34
 # @FilePath: \Online_VScode\reset_dns.sh
### 
# 指定 CSV 文件路径
folder_path="/editor/coredns/players"

# 解析命令行参数
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -path) folder_path="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

sudo systemctl stop nginx
sudo systemctl stop systemd-resolved
sudo docker restart dns

sudo echo '.:53 {
    hosts {' > /editor/coredns/Corefile

# 使用 for 循环遍历文件夹中的所有文件
for file in "$folder_path"/*; do
  # 检查是否是一个文件
  if [ -f "$file" ]; then
    # 获取文件名
    filename=$(basename "$file")
    cat $file
    sudo cat $file >> /editor/coredns/Corefile
  fi
done

sudo echo '
        198.41.30.195 open-vsx.org
        20.60.40.4 openvsxorg.blob.core.windows.net
    }
    
    forward . 114.114.114.114 8.8.8.8
    forward . /etc/resolv.conf
    
    log
    errors
}
' >> /editor/coredns/Corefile
cat /editor/coredns/Corefile

sudo sed -i 's/nameserver 8.8.8.8/nameserver 127.0.0.1/' /etc/resolv.conf
sudo sed -i 's/nameserver 127.0.0.53/nameserver 127.0.0.1/' /etc/resolv.conf

sudo docker restart coredns
sudo systemctl restart systemd-networkd
