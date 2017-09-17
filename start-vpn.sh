#!/bin/bash
#操作于：Ubuntu 14.04 x64
#vps购买：https://www.vultr.com/?ref=6966469

#开启chacha20加密方式
apt-get install build-essential
wget https://download.libsodium.org/libsodium/releases/LATEST.tar.gz
tar zxf LATEST.tar.gz
cd libsodium*
./configure
make && make install
ldconfig

#安装shadowsocks
apt-get update
apt-get install python-pip
pip install shadowsocks
# 启动shadowsocks(可以添加到/etc/rc.local) (加密算法可以安装并使用chacha20，速度更快)
ssserver -p 1984 -k yourpassword -m chacha20 -d start

#选择一 使用锐速
#内核换成24
apt-get install linux-image-extra-3.13.0-24-generic
#查看系统现有内核
dpkg -l|grep linux-image 
#卸载列出的其他内核
apt-get purge linux-image-3.13.0-105-generic linux-image-extra-3.13.0-105-generic 
#更新 grub 系统引导文件并重启
update-grub
reboot
#安装和运行锐速
wget -N --no-check-certificate --restrict-file-names=nocontrol https://raw.githubusercontent.com/91yun/serverspeeder/master/serverspeeder-all.sh && bash serverspeeder-all.sh

#选择二 使用BBR
#内核换成4.9
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.9/linux-image-4.9.0-040900-generic_4.9.0-040900.201612111631_amd64.deb
dpkg -i linux-image-4.9.0*.deb
dpkg -l|grep linux-image
apt-get purge #上面列出的非4.9的内核
update-grub
reboot
#添加bbr配置
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl –p
sysctl net.ipv4.tcp_available_congestion_control
#查看BBR是否开启
lsmod | grep bbr

