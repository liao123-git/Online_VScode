FROM debian:latest
# 换源提速
RUN echo "deb http://mirrors.aliyun.com/debian bullseye main" > /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/debian-security bullseye-security main" >> /etc/apt/sources.list  && \
    echo "deb http://mirrors.aliyun.com/debian bullseye-updates main" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install apache2 libapache2-mod-php php-mysql php-gd php-curl php-mbstring php  php-common php-fpm  php-horde-util php-mdb2 php-mysql php-net-url2 php-pear  php-xml php-xml-htmlsax3  php-xml-svg php-xmlrpc  php-cli php-common php-curl php-fpm php-gd php-json php-mbstring php-readline php-xml php-xmlrpc -y
#追加配置
RUN sh -c "echo 'ServerName localhost:80' >> /etc/apache2/apache2.conf"
#地址重写功能(实现子域名功能)
RUN a2enmod rewrite
#禁用模块(不禁用讲无法启用PHP8.2)
RUN a2dismod mpm_event
#支持PHP解析
RUN a2enmod php8.2
# 启动apache2
#清理
RUN apt-get clean
#对外暴漏默认端口,即不指定但默认提供
EXPOSE 80 443
CMD ["/usr/sbin/apache2ctl","-D","FOREGROUND"]