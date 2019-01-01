# open-falcon

### 安装
- 安装git

		yum install git -y


- 安装go
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
		# 
		cd /usr/local/go/src/github.com/open-falcon/falcon-plus
		make all
		make agent
		make pack
		


