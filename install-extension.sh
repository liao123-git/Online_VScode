#!/bin/bash
###
 # @Description: WASSUP
 # @Author: LDL <1923609016@qq.com>
 # @LastEditTime: 2024-04-12 22:06:33
 # @Date: 2024-04-11 20:06:06
 # @FilePath: \Online_VScode\install-extension.sh
### 

# 指定 CSV 文件路径
name=""
version="normal"

# 解析命令行参数
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -name) name="$2"; shift ;;
    -v) version="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

# 检查 CSV 文件是否存在
if [ -z $name ]; then
  echo "Usage: $0 -name <username>"
  exit 1
fi

echo ""
echo "------------install $name's extension--------------"

    if [ $version == "normal" ]; then
        sudo docker exec ${name}_editor /usr/bin/code-server --install-extension ecmel.vscode-html-css  /usr/bin/code-server --install-extension kisstkondoros.vscode-gutter-preview /usr/bin/code-server --install-extension tuxtina.json2yaml /usr/bin/code-server --install-extension christian-kohler.path-intellisense  /usr/bin/code-server --install-extension esbenp.prettier-vscode
    fi

    
    sudo docker exec -i ${name}_editor bash -c 'cat > /root/.local/share/code-server/Machine/settings.json' < /editor/settings.json
    sudo docker exec -i ${name}_editor bash -c 'cat > /root/.local/share/code-server/User/settings.json' < /editor/settings.json
    sudo docker restart ${name}_editor

echo "------------end install $name's extension--------------"
echo ""