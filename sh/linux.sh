# linux 服务器初始化

# vim /etc/resolv.conf
printf "nameserver\t8.8.8.8\n" >> /etc/resolv.conf

yum install -y vim wget net-tools dos2unix epel-release ntp

# 更改时区 同步时间 系统时间写入硬件时间
# ll /etc/localtime 
rm /etc/localtime -rf
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ntpdate asia.pool.ntp.org
hwclock --systohc

# 计算机名
# hostname
# vim /etc/hostname
# hostname -b <hostname>
# myip=$(curl https://api.ipify.org/)

myip=$(ifconfig | awk -F "[ :]+" 'NR==2 {print $3}')
host_name="srv$(echo $myip | awk -F "." '{print $4}')-$(date +%Y%m%d)"
echo $host_name > /etc/hostname
hostname -b $host_name

# 网卡开机启动
net_card=$(ifconfig | awk -F "[ :]+" 'NR==1 {print $1}')
# grep ONBOOT /etc/sysconfig/network-scripts/ifcfg-$net_card
sed -i s#ONBOOT=no#ONBOOT=yes# /etc/sysconfig/network-scripts/ifcfg-$net_card

# 系统版本
# cat /etc/redhat-release
# yum update

# 关闭 selinux
# vim /etc/selinux/config
sed -i s#SELINUX=enforcing#SELINUX=disabled# /etc/selinux/config
setenforce 0

# 关闭 firewalld
systemctl stop firewalld
systemctl disable firewalld

# 安装 iptables 配置并启动
yum install -y iptables-services
# vim /etc/sysconfig/iptables 	# 确保开放 sshd端口
sshd_ports=$(egrep "\<Port\>" /etc/ssh/sshd_config | awk '{print $NF}')
for sshd_port in $sshd_ports
do
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${sshd_port} -j ACCEPT
done

service iptables save
systemctl start iptables
systemctl enable iptables

# 安装 fail2ban 配置并启动
yum install -y fail2ban
cat >> /etc/fail2ban/jail.d/sshd.local <<EOF
[sshd]
enabled = true
filter = sshd
findtime = 3600
bantime = 86400
maxretry = 3
banaction = iptables-allports
EOF
systemctl start fail2ban
systemctl enable fail2ban
