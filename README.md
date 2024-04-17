<!--
 * @Description: WASSUP
 * @Author: LDL <1923609016@qq.com>
 * @LastEditTime: 2024-04-17 09:56:47
 * @Date: 2024-04-10 20:30:48
 * @FilePath: \Online_VScode\README.md
-->
# Online_VScode

## 运行
- 宿主机`ubuntu 22.0` 开放防火墙 80tcp 53udp 端口。
- 创建脚本存放目录，复制所有文件到目录下。
- 初始化
    ```sh
        # 你脚本存放的目录
    chmod -R 777 /my_shell
        # 如果镜像安装报错 重新执行
    ./init.sh
    ```
- 设置IP
    ```sh
        # ip 宿主机 IP 必填
        # interface 网卡名称 必填
        # gateway 网关 必填
    ./set_ip.sh -ip 192.168.7.215 -interface ensxx -gateway 192.168.7.254
    ```
- 创建一个比赛
  csv 会有选手的信息，运行完这个脚本会输出
    ```sh
        # num 人数 必填
        # prefix 用户名前缀
        # csv 输出 csv 文件名称 不需要带 .csv 后缀 默认 output
        # template 文件模板 默认空
    ./create_game.sh -num 10 -prefix player -csv players_info -template default
    ```
- 创建完比赛后能继续添加选手
  这个脚本添加的选手不会加到 csv 中，会在脚本目录下输出一个`$name.csv`
  ```sh
        # name 用户名 必填
        # template 文件模板 默认空
    ./create_single.sh -name test -template default
  ```
  - 保存项目成模板
  保存当前已有选手项目成模板，保存到`/editor/template/$name`
  ```sh
        # name 用户名 必填
        # template 模板名 必填
    ./save_project.sh -name test -template test
  ```
- 后面跟着 -csv 的脚本 都是通过生成的 .csv 文件来创建服务
- 没有跟的脚本都是独立的 可以独立创建某个服务 具体参数看脚本内
- 测试时记得修改 dns 指向宿主机，关代理





## 环境准备（不用看）

### docker 环境
```sh
sudo apt update
sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo systemctl status docker
sudo apt-mark hold docker-ce

sudo docker network create game
```

### 清空环境
```sh
sudo mkdir -p /test/players
sudo rm -rf /test/players/*
```

### 初始化环境
```sh
sudo docker pull tomsik68/xampp:8
```

### 运行环境
```sh
sudo docker container rm -f player1_xampp
docker run --name player1_xampp -d \
            -v /test/players/player1/project:/opt/lampp/htdocs --net game \
            tomsik68/xampp:8
```
### nginx 
```sh
sudo docker pull nginx
sudo docker rm -f nginx
sudo docker run -d --name nginx -p 80:80 --net game nginx

sudo docker exec -i nginx bash -c 'echo "server {
    listen 80;
    server_name player1.qgweb.com;

    location / {
        proxy_pass http://player1_xampp:80;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}" > /etc/nginx/conf.d/player1.conf'
```

### dns 
```sh
sudo docker pull mailcow/unbound

sudo systemctl restart systemd-networkd
sudo docker rm -f coredns
sudo echo '.:53 {
    hosts {
        nginx player1.qgweb.com
        nginx player2.qgweb.com
        nginx player10.qgweb.com

        fallthrough
    }
    
    forward . 114.114.114.114 8.8.8.8
    log
    errors
}
' > /editor/Corefile
sudo docker run -d --name coredns -p 53:53/udp -v /editor/Corefile:/etc/coredns/Corefile --net game coredns/coredns -conf /etc/coredns/Corefile
```

### coder
```sh
# 清空
sudo docker pull codercom/code-server:4.23.0
sudo mkdir -p /test/players/player1/.config 
sudo mkdir -p /test/players/player1/project 

sudo docker container rm -f player1
sudo docker run -d -it --name test -p 8080:8080 \
  -v "/test/players/player1/.config:/home/coder/.config" \
  -v "/test/players/player1/project:/home/coder/project" \
  -u "$(id -u):$(id -g)" \
  -e "PASSWORD"=aDmin@hp15 \
  codercom/code-server:4.23.0

# HTML CSS  
# Image preview
# json yaml
# C++ theme
# path
# prettier 
sudo docker exec player1 /usr/bin/code-server --install-extension ecmel.vscode-html-css  /usr/bin/code-server --install-extension kisstkondoros.vscode-gutter-preview /usr/bin/code-server --install-extension tuxtina.json2yaml /usr/bin/code-server --install-extension christian-kohler.path-intellisense  /usr/bin/code-server --install-extension esbenp.prettier-vscode
sudo docker exec -i player1 bash -c 'cat > /root/.local/share/code-server/Machine/settings.json' < /www/wwwroot/coder-server/settings.json
sudo docker exec -i player1 bash -c 'cat > /root/.local/share/code-server/User/settings.json' < /www/wwwroot/coder-server/settings.json
sudo docker restart player1
```