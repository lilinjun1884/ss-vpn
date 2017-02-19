#操作于：Ubuntu 14.04 x64

#内核换成24
apt-get install linux-image-extra-3.13.0-24-generic
#查看系统现有内核
dpkg -l|grep linux-image 
#卸载列出的其他内核
apt-get purge linux-image-3.13.0-104-generic linux-image-extra-3.13.0-104-generic 
#更新 grub 系统引导文件并重启
update-grub
reboot

#安装shadowsocks
yum install python-setuptools && easy_install pip
pip install shadowsocks

# 启动shadowsocks(可以添加到/etc/rc.local) 
ssserver -p 1984 -k zx123456 -m rc4-md5 -d start

#安装和运行锐速
wget -N --no-check-certificate --restrict-file-names=nocontrol https://raw.githubusercontent.com/91yun/serverspeeder/master/serverspeeder-all.sh && bash serverspeeder-all.sh
