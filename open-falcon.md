# open-falcon

### 安装
- 安装依赖

		yum install gcc -y
- 安装mysql和redis

		yum install -y redis
		yum install -y mysql-server
- 安装git(Git >= 1.7.5)

		yum install git -y


- 安装go(Go >= 1.6)
	- 下载：
	
			wget https://dl.google.com/go/go1.11.4.linux-amd64.tar.gz
	- 安装：
	
			tar -C /usr/local -xzf go1.11.4.linux-amd64.tar.gz
	- 添加环境变量：
	
			vim /etc/profile.d/go.sh
			export PATH=$PATH:/usr/local/go/bin

- 安装open-falcon
	
		mkdor -pv /usr/local/go/src/github.com/open-falcon
		git clone https://github.com/open-falcon/falcon-plus.git
		# 导入数据
		cd /usr/local/go/src/github.com/open-falcon/falcon-plus/scripts/mysql/db_schema
		mysql < 1_uic-db-schema.sql
		mysql < 2_portal-db-schema.sql 
		mysql < 3_dashboard-db-schema.sql 
		mysql < 4_graph-db-schema.sql 
		mysql < 5_alarms-db-schema.sql
		# 编译
		cd /usr/local/go/src/github.com/open-falcon/falcon-plus
		make all
		make agent
		make pack
		

- 安装后端

		mkdir ~/open-falcon
		tar -xzvf /usr/local/go/src/github.com/open-falcon/falcon-plus/open-falcon-v0.2.1.tar.gz -C ~/open-falcon/
		cd open-falcon/
		# 启动
		./open-falcon start
		# 查看状态
		./open-falcon check
		

- 安装前端

		cd ~/open-falcon
		git clone https://github.com/open-falcon/dashboard.git
	- 安装依赖

			yum install -y python-virtualenv
			yum install -y python-devel
			yum install -y openldap-devel
			yum install -y mysql-devel
			yum groupinstall "Development tools"
	- 使用虚拟环境启动前端

			# 推荐使用py3
			yum install python36
			# 安装pip(py3)
			wget https://bootstrap.pypa.io/get-pip.py
			python36 get-pip.py 
			# 安装虚拟环境及扩展包
			pip install virtualenv
			pip install virtualenvwrapper
[虚拟环境使用](./virtualenv.md "虚拟环境使用")
