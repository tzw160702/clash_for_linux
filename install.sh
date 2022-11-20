#!/bin/bash
# 报错自动退出
set -o errexit
# set +o errexit 

echo "--------------------clash 安装--------------------"
# 获取当前路径
CURRENT_DIR=$(cd `dirname $0`; pwd)

# 创建目录
mkdir -p /usr/local/bin/proxy

# 解压
rm -f /usr/local/bin/proxy/clash
gzip -dc < ./dep/clash-linux-amd64-v1.11.12.gz > /usr/local/bin/proxy/clash

# 添加可执行权限
chmod +x /usr/local/bin/proxy/clash

# 配置文件
cp -r $CURRENT_DIR/conf/clash /root/.config

killapplication() {
    PID=$(netstat -nlp | grep :7890 | awk '{print $7}' | awk -F"/" '{ print $1 }')
    if [ -z $PID ]
    then
       echo Application is already stopped.
    else
       echo kill $PID
       kill -9 $PID 
    fi    
}        
# 关闭端口占用的进程 
killapplication

# system 脚本方便启动服务,ubuntu需要写入到这个目录下:/etc/systemd/system/
echo "[Unit]
Description=Clash Daemon

[Service]
ExecStart=/usr/local/bin/proxy/clash -d /root/.config/clash/
Restart=on-failure

[Install]
WantedBy=multi-user.target
" > /usr/lib/systemd/system/clash.service


# 启动服务 
systemctl start clash.service

# 设置开机自启动
# sudo systemctl enable clash.service  

# 查看服务, ubuntu 需要注释掉此行
systemctl status clash.service  

echo "--------------------proxychains4 安装--------------------"
# proxychains4 安装
# 编译、安装
tar -zxvf ./dep/proxychains-ng-4.16.tar.gz -C ./dep
cd $CURRENT_DIR/dep/proxychains-ng-4.16
./configure --prefix=/usr --sysconfdir=/etc
make && make install

# 创建配置文件
make install-config

# 更改配置
# echo "
# socks5  127.0.0.1 7890
# http    127.0.0.1 7890
# " >> /etc/roxychains.conf
cp $CURRENT_DIR/conf/proxychains.conf /etc

echo "
    安装完成!
    运行命令进行测试: 【proxychains4 curl www.google.com】
"