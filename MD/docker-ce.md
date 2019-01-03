#### 1.LXC是什么？
- LXC是Linux containers的简称，是一种基于容器的操作系统层级的虚拟化技术。

#### 2.LXC可以做什么？
- LXC可以在操作系统层次上为进程提供的虚拟的执行环境，一个虚拟的执行环境就是一个容器。可以为容器绑定特定的cpu和memory节点，分配特定比例的cpu时间、IO时间，限制可以使用的内存大小（包括内存和是swap空间），提供device访问控制，提供独立的namespace（网络、pid、ipc、mnt、uts）。

### 3.LXC如何实现？
- Sourceforge上有LXC这个开源项目，但是LXC项目本身只是一个为用户提供一个用户空间的工具集，用来使用和管理LXC容器。LXC真正的实现则是靠Linux内核的相关特性，LXC项目只是对此做了整合。基于容器的虚拟化技术起源于所谓的资源容器和安全容器。LXC在资源管理方面依赖与Linux内核的cgroups子系统，cgroups子系统是Linux内核提供的一个基于进程组的资源管理的框架，可以为特定的进程组限定可以使用的资源。LXC在隔离控制方面依赖于Linux内核的namespace特性，具体而言就是在clone时加入相应的flag（NEWNS  NEWPID等等）。

#### 4.为什么要选择LXC？
- LXC是所谓的操作系统层次的虚拟化技术，与传统的HAL（硬件抽象层）层次的虚拟化技术相比有以下优势：
	- 1. 更小的虚拟化开销（LXC的诸多特性基本由内核特供，而内核实现这些特性只有极少的花费，具体分析有时间再说）
	- 2. 快速部署。利用LXC来隔离特定应用，只需要安装LXC，即可使用LXC相关命令来创建并启动容器来为应用提供虚拟执行环境。传统的虚拟化技术则需要先创建虚拟机，然后安装系统，再部署应用。LXC跟其他操作系统层次的虚拟化技术相比，最大的优势在于LXC被整合进内核，不用单独为内核打补丁。


============基于docker-ce-18.03.1-ce====================================================

安装docker-ce

	# 卸载老版本docker-ce:
	yum remove docker \
				docker-client \
				docker-client-latest \
				docker-common \
				docker-latest \
				docker-latest-logrotate \
				docker-logrotate \
				docker-selinux \
				docker-engine-selinux \
				docker-engine

	# 安装docker-ce
	yum install -y yum-utils \
					device-mapper-persistent-data \
					lvm2

	yum-config-manager \
		--add-repo \
		https://download.docker.com/linux/centos/docker-ce.repo

	# 可选操作：
		# 开启edge支持
	yum-config-manager --enable docker-ce-edge
	yum-config-manager --enable docker-ce-test

		# 关闭edge支持
	yum-config-manager --disable docker-ce-edge

	# 查看re哪些docker版本：
	yum list docker-ce --showduplicates | sort -r

	yum install docker-ce


#### docker基本操作
- docker search <关键字>
- docker pull <镜像名>
- docker push 
- docker images 	//查看本地镜像
- docker rm <容器id>
- docker rmi <镜像id> 	//所有关联容器都删除了才可以删除镜像

- docker run -d -i -t <容器id>

- docker start/stop/restart/kill <容器id>

- docker ps
- docker ps -a
- docker ps -a -q

- docker rm `docker ps -a -q`		//删除所有容器

#### 登陆容器
	# ssh <user>@<ip> [-p <port>]

	# docker attach <容器id>
	# docker exec -it <容器id> /bin/bash

#### nsenter工具：
	# 下载：https://mirrors.edge.kernel.org/pub/linux/utils/util-linux
	wget https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.32/util-linux-2.32.tar.gz

	tar xaf util-linux-2.32.tar.gz
	cd util-linux-2.32
	./configure --without-ncurses ;make nsenter
	cp nsenter /usr/local/bin/
	
	# nseter --target <容器pid> --mount --uts --ipc --net --pid
	# 简写：
	# nsenter -t <容器pid> -m -u -i -n -p
	# 获取容器pid:
	PID=$(docker inspect --format "{{ .State.Pid }}" <container_id>)
	PID=$(docker inspect -f "{{ .State.Pid }}" <container_id>)
	nsenter -t $PID -m -u -i -n -p


#### 自定义脚本：
		# vim bashrc_docker

		#/bin/bash

		function docker-pid() {
			docker inspect --format "{{ .State.Pid}}" $1;
		}

		function docker-enter () {
			docker_pid=$(docker inspect --format "{{ .State.Pid}}" $1);
			nsenter -t $docker_pid -m -u -i -n -p $2
		}


##### 删除untagged image,也就是ID为<None>的image，可以用：
		# docker rmi $(docker images | grep "^<none>" | awk "{print $3}")

##### 删除全部image：
	docker rmi $(docker images -q)

##### 导出镜像存储：
	# docker save <镜像id/镜像标识> > name_img.tar
	# 导入镜像存储：
	docker load < name_img.tar

##### 导出容器：（快照）
	docker export <容器id> > name_con.tar
	docker export --output=name_con_1.tar <容器id>
	docker export -o name_con_2.tar <容器id>

##### 导入容器（为镜像）： 从快照文件中导入为镜像
	cat name_con.tar | docker import - test/centos:v1.0
	docker import name_con_1.tar test/centos:v2.0

##### 如果要修改docker数据根目录，需要手动创建docker配置文件，docker v1.11后默认没有配置文件：
	/etc/docker/daemon.json
	/var/lib/docker
	/etc/systemd/system/docker.service.d/docker.conf
	/var/log/messages
	/etc/systemd/system/docker.service.d/http-proxy.conf


#### Docker 数据管理：
- 容器中数据管理主要有两种方式：
	- 数据卷
		-数据卷容器

- 创建数据卷：

		docker run -idt -v /path:/con_path --name 容器名称> <镜像名称/镜像id> /bin/bash


##### 官方mysql镜像：
- 需要指定以下三个参数其中之一:
	- MYSQL_ROOT_PASSWORD
	- MYSQL_ALLOW_EMPTY_PASSWORD
	- MYSQL_RANDOM_ROOT_PASSWORD

			docker run -idt --name mysql_10 -e MYSQL_ROOT_PASSWORD="123456" mysql	

### Dockerfile
- 四部分组成：
	- 基础镜像信
	- 维护者信息
	- 镜像操作指令
	- 容器启动时执行指令
- 字段：
	- FROM <镜像名>
	- MAINTAINER <维护者>
	- RUN <执行命令>
	- EXPOSE <指定端口>
	- ENV <设定环境变量>
	- ADD/COPY <将宿主机文件复制到容器，ADD会解包打包文件>
	- CMD <启动容器时行会执行的命令，可以执行脚本以执行多个命令>
	- ENTRYPOINT <不会被 docker run 提供的参数覆盖>
	- VOLUME <指定数据卷>
	- USER <指定用户>
	- WORKDIR 
	- ONBUILD



### Docker编排工具：docker-compose
- 安装：

		curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
		chmod +x /usr/local/bin/docker-compose
		docker-compose version