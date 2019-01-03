### 虚拟环境
- 包的安装

		pip3 install 包名称
- 为什么使用虚拟环境
	- 如果在一台机器上，想开发多个不同的项目，需要用到同一个包的不同版本，如果还使用上面的命令，在同一个目录下安装或者更新，其它的项目必须就无法运行了，怎么办呢？
	- 解决方案：虚拟环境
	- 虚拟环境其实就是对真实pyhton环境的复制，这样我们在复制的python环境中安装包就不会影响到真实的python环境。通过建立多个虚拟环境，在不同的虚拟环境中开发项目就实现了项目之间的隔离

- 安装虚拟环境：

		pip3 install virtualenv # 安装虚拟环境
		pip3 install virtualenvwrapper # 安装虚拟环境扩展包

		# 安装虚拟环境包装器的目的是使用更加简单的命令来管理虚拟环境。
		# 修改用户家目录下的配置文件.bashrc,添加如下内容：
		# 指定虚拟环境存储路径：
		export WORKON_HOME=$HOME/.virtualenvs
		export PROJECT_HOME=$HOME/env
		# which python3 查询 pyton3 路径，填写在下方：
		VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
		source /usr/local/bin/virtualenvwrapper.sh

- 使用

		# 创建python3虚拟环境的命令如下：
		# mkvirtualenv -p python3 虚拟环境名称
		# 例：
		mkvirtualenv -p python3 py_django

		# 进入虚拟环境：
		# workon 虚拟环境名称
		# 例：
		workon py_django

		# 退出虚拟环境
		deactivate

		# 删除虚拟环境：
		# 删除之前，需要先退出虚拟环境
		# rmvirtualenv 虚拟环境名称
		# 例：
		rmvirtualenv py_django

		# 虚拟环境里的一些操作：
		# 虚拟环境里安装包不能用 sudo，否则会安装在真实环境
		workon py_test
		(py_test) [root@srv132-20180924 ~]
		pip install django==1.8.2

		pip list 查看包
		(py_test) [root@srv132-20180924 ~]# pip list
		Package    Version
		---------- -------
		pip        18.1   
		setuptools 40.6.2 
		wheel      0.32.2

		pip freeze # 查看包
		(py_test) [root@srv132-20180924 ~]# pip freeze
		Django==1.8.2
