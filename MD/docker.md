
##### NameSpace：

	内核级别，环境隔离；
	
	PID NameSpace：Linux 2.6.24，PID隔离
	Network NameSpace：Linux 2.6.29，网络设备、网络栈、端口等网络资源隔离
	User NameSpace：Linux 3.8，用户和用户组资源隔离
	IPC NameSpace：Linux 2.6.19，信号量、消息队列和共享内存的隔离
	UTS NameSpace：Linux 2.6.19，主机名和域名的隔离；
	Mount NameSpace：Linux 2.4.19，挂载点（文件系统）隔离；
	
	API：clone(), setns(), unshare()；
	
##### CGroup：Linux Control Group, 控制组， Linux 2.6.24
	内核级别，限制、控制与一个进程组群的资源；
	
	资源：CPU，内存，IO
	
	功能：
		Resource limitation：资源限制；
		Prioritization：优先级控制；
		Accounting：审计和统计，主要为计费；
		Control：挂起进程，恢复进程；
		
	/sys/fs/cgroup
	mount
	lssubsys -m
	
	CGroups的子系统（subsystem）：
		blkio：设定块设备的IO限制；
		cpu：设定CPU的限制；
		cpuacct：报告cgroup中所使用的CPU资源；
		cpuset：为cgroup中的任务分配CPU和内存资源；
		memory：设定内存的使用限制；
		devices：控制cgroup中的任务对设备的访问；
		freezer：挂起或恢复cgroup中的任务；
		net_cls：（classid），使用等级级别标识符来标记网络数据包，以实现基于tc完成对不同的cgroup中产生的流量的控制；
		perf_event：使用后使cgroup中的任务可以进行统一的性能测试；
		hugetlb：对HugeTLB系统进行限制；
		
	CGroups中的术语：
		task（任务）：进程或线程；
		cgroup：一个独立的资源控制单位，可以包含一个或多个子系统；
		subsystem：子系统
		hierarchy：层级
	
##### AUFS：UnionFS
	UnionFS：把不同的物理位置的目录合并到同一个目录中。
	
	Another UFS, Alternative UFS, Adanced UFS
	
##### Device mapper：
	Linux 2.6内核引入的最重要的技术之一，用于在内核中支持逻辑卷管理的通用设备映射机制；
		Mapped Device
		Mapping Table
		Target Device
	
============================================================================================================
### Docker：
- 2013, GO, Apache 2.0, dotCloud
	
- C/S:
		Docker Client: 发起docker相关的请求；
		Docker Server: 容器运行的节点；
		
- 核心组件：
	- docker client：docker的客户端工具，是用户使用docker的主要接口，docker client与docker daemon通信并将结果返回给用户；
	- docker deamon：运行于宿主机上，Docker守护进程，用户可通过docker client与其交互；
	- image：镜像文件是只读的；用来创建container，一个镜像可以运行多个container；镜像文件可以通过Dockerfile文件创建，也可以从- - docker hub/registry下载；
		- repository
		- 公共仓库：Docker hub/registry
		- 私有仓库：docker registry
			
		docker container：docker的运行实例，容器是一个隔离环境； 
		
	- 另外两个重要组件：
		- docker link：
		- docker volume：
			
- docker的常用命令：
	- 环境信息相关：
		- info
		- version
	- 系统维护相关：
		- images
		- inspect
		- build
		- commit
		- pause/unpause
		- ps
		- rm
		- rmi
		- run
		- start/stop/restart
		- top
		- kill
		- ...
	- 日志信息相关：
		- events
		- history
		- logs
	- Docker hub服务相关：
		- login
		- logout
		- pull
		- push
		- search
			
	- 基本操作：
		- 获取映像：pull
		- 启动容器：run
			- -i, -t
			
	- 总结：
		- 安装，启动服务；
		- docker hub注册账号；
		- 获取镜像；
		- 启动容器；
		
	- dockerfile：
		
##### 回顾：
	container:
		namespace：network, pid, ipc, user, uts, mount
		cgroups ：子系统，cpu, memory, cpuset, cpuacct, ...
		
		lxc, openvz
		
	docker：
		lxc
		libcontainer
		
	安装：
		CentOS 6：epel
		CentOS 7: extra
			docker-engine
			
	C/S：
		systemctl  start  docker.server: docker daemon 
		
		docker
		
### Docker：
- Docker功能：
	- 隔离应用
	- 维护镜像
	- 创建易于分发的应用
	- 快速扩展
		
- Docker：
	- 镜像
	- 容器
	- 链接
	- 数据卷
		
- Docker应用：
	- 镜像：包含了启动Docker容器所需要的文件系统层级及其内容；基于UnionFS采用分层结构实现；
		- bootfs
		- rootfs
				
	- registry：保存docker镜像及镜像层次结构和元数据；
	- repository：由具有某个功能的镜像的所有相关版本构成的集合；
	- index：管理用户的账号、访问权限、镜像及镜像标签等等相关的；
	- graph：从registry中下载的Docker镜像需要保存在本地，此功能即由graph完成；
		- /var/lib/docker/graph,
				
	- 与镜像相关的命令：
		- images
		- search
		- pull
		- push
		- login
		- logout		
		- 创建镜像：commit, build
		- 删除本地镜像：rmi
			
	- 容器：
		- 独立运行的一个或一组应用，以及它们运行的环境；
			
		- 命令：
			- run, kill, stop, start, restart，log，export, import
				
		- 启动方法：
			- 通过镜像创建一个新的容器；run
			- 启动一个处于停止状态的容器；start
				
		- run命令：
			- --name=                         Assign a name to the container
			- -i, --interactive=false         Keep STDIN open even if not attached
			- -t, --tty=false                 Allocate a pseudo-TTY
			- --net=default			Set the Network for the container
			- -d, --detach=false              Run container in background and print container ID
				
			- 步骤：
				- 检查本地是否存在指定的镜像，不存在则从registry下载；
				- 利用镜像启动容器
				- 分配一个文件系统，并且在只读的镜像层之外挂载一个可读写层；
				- 从宿主机配置的网桥接口桥接一个虚拟接口给此容器；
				- 从地址池中分配一个地址给容器；
				- 执行用户指定的应用程序；
				- 程序执行完成后，容器即终止；
					
				对于交互式模式启动的容器，终止可使用exit命令或ctrl+d组合键；
					
			- logs命令：获取一个容器的日志，获取其输出信息；
			
			- attach命令：附加至一个运行中的容器；
			
	- Docker Hub：
		- registry有两种：
			- docker hub：
					
			- private registry：
				- (1) 安装docker-registry程序包；
				- (2) 启动服务：
					- systemctl  start  docker-registry.service
					
				- (3) 建议使用nginx反代：使用ssl，基于basic做用户认证；
					
			- docker端使用私有仓库：
				- (1) 配置文件 /etc/sysconfig/docker
					- ADD_REGISTRY='--add-registry 172.16.100.68:5000'
					- INSECURE_REGISTRY='--insecure-registry 172.16.100.68:5000'
						
				- (2) push镜像
					- (a) tag命令：给要push到私有仓库的镜像打标签；
						- docker tag  IMAGE_ID  REGISRY_HOST:PORT/NAME[:TAG]
					- (b) push命令：
						- docker  push  REGISRY_HOST:PORT/NAME[:TAG]
							
				- (3) pull镜像
					- docker  pull  REGISRY_HOST:PORT/NAME[:TAG]
						
	- Docker的数据卷：
		- Data Volume
			
		- 数据卷是供一个或多个容器使用的文件或目录，有多种特性：
			- 可以共享于多个容器之间；
			- 对数据卷的修改会立即生效；
			- 对数据卷的更新与镜像无关；
			- 数据卷会一直存在；
				
		- 使用数据卷的方式：
			- (1) -v  /MOUNT_POINT
				- 默认映射的宿主机路径：/var/lib/docker/volumes/
			- (2) -v  /HOST/DIR:/CONTAINER/DIR 
				- /HOST/DIR: 宿主机路径
				- /CONTAINER/DIR ：容器上的路径
			- (3) 在Dockerfile中使用VOLUME指令定义；
				
		- 在容器之间共享卷：
			- --volumes-from=[]               Mount volumes from the specified container(s)
			- 后跟容器名；
					
		- 删除卷：
			- docker  rm  -v  CONTAINER_NAME
				- 删除容器的同时删除其卷；
			- docker  run  --rm选项，表示容器关闭会被自动删除，同时删除其卷（此容器为最后一个使用此卷的容器时）；
				
			备份和恢复：
				备份：
					docker  run  --rm  --volumes-from  vol_container  -v  $(pwd):/backup  busybox:latest  tar  cvf  /backup/data.tar  /data
					
##### 回顾：
	容器技术；
		docker client/docker daemon
			docker镜像；
			docker registry；
			docker container；
			
	volume：
	
	single host, multi host
		
	单一程序：
	
	集装箱：
		test.java
		
### Docker Network：
- 容器的网络模型：
	- closed container：
		- 仅有一个接口：loopback
		- 不参与网络通信，仅适用于无须网络通信的应用场景，例如备份、程序调试等；
		- --net  none
		
	- bridged container:
		- 此类容器都有两个接口：
			- loopback
			- 以太网接口：桥接至docker daemon设定使用的桥，默认为docker0；
				
		- --net  bridge 
			- -h, --hostname  HOSTNAME
			- --dns  DNS_SERVER_IP
			- --add-host  "HOSTNAME:IP" 
			
		- docker0 NAT桥模型上的容器发布给外部网络访问：
			- -p  <containerPort>
				- 仅给出了容器端口，表示将指定的容器端口映射至主机上的某随机端口；
			- -p  <hostPort>:<containerPort>
				- 将主机的<hostPort>映射为容器的<containerPort>			
			- -p  <hostIP>::<containerPort>
				- 将主机的<hostIP>上的某随机端口映射为容器的<containerPort>		
			- -p <hostIP>:<hostPort>:<containerPort>
				- 将主机的<hostIP>上的端口<hostPort>映射为容器的<containerPort>
			- -P, --publish-all 
				- 发布所有的端口，跟--expose选项一起指明要暴露出外部的端口；
					
		- 如果不想启动容器时使用默认的docker0桥接口，需要在运行docker daemon命令时使用
			- -b选项：指明要使用桥；
			
	- 联盟式容器：
		- 启动一个容器时，让其使用某个已经存在的容器的网络名称空间；	
		- --net container:CONTAINER_NAME 
			
	- 开放式容器：
		- 容器使用Host的网络名称空间；
		- --net  host
			
	- 容器间的依赖关系：
		- 链接机制：linking
			- --link
			
	- 容器的资源限制：
		- run命令的选项：
			- -m
			- --cpuset-cpus 
			- --shm-size 
			- ...
	- docker的监控命令：
		- ps命令：
			- -a
		- images命令：
			- 查看当前主机的镜像信息； 	
		- stats命令：
			- 容器状态统计信息，实时监控容器的运行状态；
		- inspect命令：
			- 查看镜像或容器的底层详细信息；
				- -f, --format 
					- {{.key1.key2....}}
		- top命令：
			- 用于查看正在运行的容器中的进程的运行状态；
		- port命令：
			- 查看端口映射；
			
	- 监控工具：google/cadvisor镜像
	
### Dockerfile：
- Docker Images：
	- docker commit
	- Dockerfile：文本文件，镜像文件构建脚本；
		
- Dockerfile：由一系列用于根据基础镜像构建新的镜像文件的专用指令序列组成；
	- 指令：选定基础镜像、安装必要的程序、复制配置文件和数据文件、自动运行的服务以及要暴露的端口等；
	- 命令：docker build；
	- 语法：指令行、注释行和空白行；
		- 指令行：由指令及指令参数构成；
			- 指令：其字符不区分大小写；约定俗成，要使用全大写字符；
		- 注释行：#开头的行，必须单独位于一行当中；
		- 空白行：会被忽略；
			
		- 指令：
			- FROM指令：必须是第一个非注释行，用于指定所用到的基础镜像；
			- 语法格式：
				- FROM  <image>[:<tag>] 或
				- FROM  <image>@<digest>
				- FROM  busybox:latest
				- FROM centos:6.9
				
				注意：尽量不要在一个dockerfile文件中使用多个FROM指令；
				
			- MAINTANIER指令：用于提供信息的指令，用于让作者提供本人的信息；不限制其出现的位置，但建议紧跟在FROM之后；
				- 语法格式：
					- MAINTANIER  <author's detail>
					
			- 例如：
				- MAINTANIER  MageEdu Linux Operation and Maintance Institute <mage@magedu.com>
					
			- COPY指令：用于从docker主机复制文件至正在创建的映像文件中；
				- 语法格式：
					- COPY  <src> ...  <dest>
					- COPY  ["<src>",...  "<dest>"]  （文件名中有空白字符时使用此种格式）
					- <src>：要复制的源文件或目录，支持使用通配符；
					- <dest>：目标路径，正在创建的镜像文件的文件系统路径；建立使用绝对路径，否则，则相对于WORKDIR而言；
					
					所有新复制生成的目录文件的UID和GID均为0；
					
				- 例如：
					- `COPY  server.xml  /etc/tomcat/server.xml`
					- `COPY  *.conf   /etc/httpd/conf.d/`
					
				- 注意：
					- <src>必须是build上下文中的路径，因此，不能使用类似“../some_dir/some_file”类的路径；
					- <src>如果是目录，递归复制会自动行；如果有多个<src>，包括在<src>上使用了通配符这种情形，此时<dest>必须是目录，而且必须得以/结尾；
					- <dest>如果事先不存在，它将被自动创建，包括其父目录；
					
			- ADD指令：类似于COPY指令，额外还支持复制TAR文件，以及URL路径；
				- 语法格式：
					- ADD  <src> ...  <dest>
					- ADD  ["<src>",...  "<dest>"]	
					
				- 示例：
					- `ADD  haproxy.cfg  /etc/haproxy/haproxy.cfg ` 
					- `ADD  logstash_*.cnf   /etc/logstash/`
					- `ADD   http://www.magedu.com/download/nginx/conf/nginx.conf   /etc/nginx/`
					
					- 注意：以URL格式指定的源文件，下载完成后其目标文件的权限为600；
					
				- 注意：
					- <src>必须是build上下文中的路径，因此，不能使用类似“../some_dir/some_file”类的路径；
					- 如果<src>是URL，且<dest>不以/结尾，则<src>指定的文件将被下载并直接被创建为<dest>；如果<dest>以/结尾，- - 则URL指定的文件将被下载至<dest>中，并保留原名；
					- 如果<src>是一个host本地的文件系统上的tar格式的文件，它将被展开为一个目录，其行为类似于tar  -x命令；但是，如果通过URL下载到的文件是tar格式的，是不会自动进行展开操作的；
					- <src>如果是目录，递归复制会自动行；如果有多个<src>，包括在<src>上使用了通配符这种情形，此时<dest>必须是目录，而且必须得以/结尾；
					- <dest>如果事先不存在，它将被自动创建，包括其父目录；					
						
			- ENV指令：定义环境变量，此些变量可被当前dockerfile文件中的其它指令所调用，调用格式为$variable_name或- - - - ${variable_name}；
				- 语法：
					- ENV  <key>  <value>    一次定义一个变量
					- ENV  <key>=<value> ...   一次可定义多个变量 ，如果<value>中有空白字符，要使用\字符进行转义或加引号；
					
				- 例如：
					
							ENV  myName="Obama Clark"   myDog=Hello\ Dog  \
							myCat=Garfield`
						
					- 等同于：
					
							ENV myName  Obama Clark
							ENV myDog  Hello Dog 
							ENV myCat  Garfield
					
				ENV定义的环境变量在镜像运行的整个过程中一直存在，因此，可以使用inspect命令查看，甚至也可以在docker  run启动此镜像时，使用--env选项来修改指定变量的值；
				
			- USER指令：指定运行镜像时，或运行Dockerfile文件中的任何RUN/CMD/ENTRYPOINT指令指定的程序时的用户名或UID；
				- 语法格式：
					- USER  <UID>|<Username>
					
				- 注意：<UID>应该使用/etc/passwd文件存在的用户的UID，否则，docker run可能会出错；
				
			- WORKDIR指令：用于为Dockerfile中所有的RUN/CMD/ENTRYPOINT/COPY/ADD指令指定工作目录；
				- 语法格式：
					- WORKDIR  <dirpath>
					
				- 注意：WORDIR可出现多次，也可使用相对路径，此时表示相对于前一个WORKDIR指令指定的路径；WORKDIR还可以调用由ENV定义的环境变量的值；
				
				- 例如：
				
						WORKDIR  /var/log 
						WORKDIR  $STATEPATH
					
			- VOLUME指令：用于目标镜像文件中创建一个挂载点目录，用于挂载主机上的卷或其它容器的卷；
				- 语法格式：
					- VOLUME  <mountpoint>
					- VOLUME  ["<mountpoint>", ...]
					
				- 注意：
					- 如果mountpoint路径下事先有文件存在，docker run命令会在卷挂载完成后将此前的文件复制到新挂载的卷中；
					
			- RUN指令：用于指定docker build过程中要运行的命令，而不是docker run此dockerfile构建成的镜像时运行；
				- 语法格式：
					- RUN  <command> 或
					- RUN  ["<executeable>", "<param1>", "<param2>", ...]
					- RUN ["/bin/bash", "-c", "<executeable>", "<param1>", "<param2>", ...]
					
				- 例如：
				
						RUN  yum  install  iproute nginx  && yum clean all  
				
			- CMD指令：类似于RUN指令，用于运行程序；但二者运行的时间点不同；CMD在docker run时运行，而非docker build；
				- CMD指令的首要目的在于为启动的容器指定默认要运行的程序，程序运行结束，容器也就结束；不过，CMD指令指定的程序可被docker run命令行参数中指定要运行的程序所覆盖。
				- 语法格式：
					- CMD  <command>  或
					- CMD  ["<executeable>", "<param1>", "<param2>", ...]  或
					- CMD [ "<param1>", "<param2>", ...]
					
					- 第三种为ENTRYPOINT指令指定的程序提供默认参数；
					
				- 注意：如果dockerfile中存在多个CMD指令，仅最后一个生效；
				
						CMD  ["/usr/sbin/httpd", "-c","/etc/httpd/conf/httpd.conf"]
					
			- ENTRYPOINT指令：类似于CMD指令，但其不会被docker run的命令行参数指定的指令所覆盖，而且这些命令行参数会被当作参数送给ENTRYPOINT指令指定的程序；
				但是，如果运行docker  run时使用了--entrypoint选项，此选项的参数可当作要运行的程序覆盖ENTRYPOINT指令指定的程序；
				- 语法格式：
					- ENTRYPOINT  <command> 或
					- ENTRYPOINT   ["<executeable>", "<param1>", "<param2>", ...]	
					
				- 例如：
				
						CMD ["-c"]
						ENTRYPOINT  ["top", "-b"]
					
			- EXPOSE指令：用于为容器指定要暴露的端口；
				- 语法格式：
					- EXPOSE   <port>[/<protocol>]  [<port>[/<protocol>]] ...
					- <protocol>为tcp或udp二者之一，默认为tcp；
					
				- 例如：`EXPOSE  11211/tcp  11211/udp `
					
			- ONBUILD指令：定义触发器；
				- 当前dockerfile构建出的镜像被用作基础镜像去构建其它镜像时，ONBUILD指令指定的操作才会被执行；
				- 语法格式：
					- ONBUILD  <INSTRUCTION>
					
				- 例如：`ONBUILD  ADD  my.cnf   /etc/mysql/my.cnf`
					
				- 注意：ONBUILD不能自我嵌套，且不会触发FROM和MAINTAINER指令；
				
			- 示例1：
			
					FROM busybox:latest
					MAINTAINER MageEdu <mage@magedu.com>
	
					COPY index.html  /web/html/index.html
	
					EXPOSE 80/tcp
	
					CMD ["httpd","-f","-h","/web/html"]	

				
			WORKDIR： /tmp/busybox-web
				- index.html
				- busybox-web.df
				
				~]# docker build  -f  /tmp/busybox-web/busybox-web.cf  -t  busybox:web   /tmp/busybox 
				~]# docker images
								
			- 示例2：httpd
				

		
				
##### 练习：
- （1）构建一个基于centos的httpd镜像，要求，其主目录路径为/web/htdocs，且主页存在，并以apache用户的身份运行，暴露80端口；
- （2）进一步地，其页面文件为主机上的卷；
- （3）进一步地，httpd支持解析php页面；
- （4）构建一个基于centos的maridb镜像，让容器间可互相通信；
- （5）在httpd上部署wordpress；
			
	
	- 容器导入和导出：
	
			docker  export 
			docker  import 
		
	- 镜像的保存及装载：
	
			docker  save  -o  /PATH/TO/SOMEFILE.TAR  NAME[:TAG]
		
			docker  load  -i  /PATH/FROM/SOMEFILE.TAR 
		
##### 回顾：
- Dockerfile指令：
	- FROM，MAINTAINER
	- COPY，ADD
	- WORKDIR， ENV 
	- USER
	- VOLUME
	- EXPOSE 
	- RUN 
	- CMD，ENTRYPOINT
	- ONBUILD
		
- Dockerfile(2)
	- 示例2：httpd
	
			FROM centos:latest
			MAINTAINER MageEdu "<mage@magedu.com>"
	
			RUN sed -i -e 's@^mirrorlist.*repo=os.*$@baseurl=http://172.16.0.1/cobbler/ks_mirror/$releasever/@g' -e '/	^mirrorlist.*repo=updates/a enabled=0' -e '/^mirrorlist.*repo=extras/a enabled=0' /etc/yum.repos.d/CentOS-Base.repo && \
			yum -y install httpd php php-mysql php-mbstring && \
			yum clean all && \
			echo -e '<?php\n\tphpinfo();\n?>' > /var/www/html/info.php

			EXPOSE 80/tcp

			CMD ["/usr/sbin/httpd","-f","/etc/httpd/conf/httpd.conf","-DFOREGROUND"]	
				
					
					
					
				
				
					
						
					
					
					
				
				
				
						
				
			
				
			
		
			
		
			
	
	
	
	
	
	
	
	
	
	
	
	
	
