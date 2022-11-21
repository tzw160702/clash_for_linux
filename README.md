## 1.clash 下载
``````
wget https://github.com/Dreamacro/clash/releases/download/v1.11.12/clash-linux-amd64-v1.11.12.gz
``````

## 2.proxychains 下载

```
wget -O proxychains-ng-4.16.tar.gz https://codeload.github.com/rofl0r/proxychains-ng/tar.gz/refs/tags/v4.16
```

**这两个压缩包需放在`/clash_for_linux/dep`目录下**

## 使用方法

### 1. 运行

```
sh install.sh
# 如果系统是Ubuntu, system 脚本需要更改目录为: /etc/systemd/system/。
# 脚本中的 /conf/config.yaml 文件须替换成自己的所购买的服务商配置文件；
# 可以从 clash for winwods 软件中导出。
```

### 2. 使用
```
proxychains4 curl www.google.com
```

<font color=red>注：</font>不使用时：运行`systemctl stop clash` 可停止 clash 服务。 
