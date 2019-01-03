
![IP签名](https://tool.lu/netcard/)

- URL:

		# 程序员工具箱
		https://tool.lu/
		# 免费代理-米扑代理(网站不能复制粘贴，可以爬取，端口可以用简单图片识别:tesseract(pytesseract模块))
		https://proxy.mimvp.com/freesecret.php
		# IP地址是否可用查询:
		https://ipcheck.need.sh/
		http://ping.pe
- Google浏览器插件：
	- JSONViwe
	- XPath Helper
	- Google翻译
- Windows换行符转换成Linux换行符:

		换行符转换成linux
		尾行模式  set ff=unix
		yum install dos2unix
		命令模式 dos2unix test.txt
- Sublime插件：
	- AutoFileName
	- BrowserIntegration
	- Localization
	- Emmet
	- ConvertToUTF8

- [Atom插件：](https://blog.csdn.net/u013474104/article/details/79373975 "Atom插件")
	- emmet: Web 快速开发，HTML/CSS 速写神器
	- pretty-json: Atom包自动格式化JSON文件
	- atom-html-preview: HTML预览，Atom编辑器的实时预览工具
	- markdown-preview: 使用显示当前编辑器右侧的呈现的HTML标记ctrl-shift-m 
	- line-ending-selector: 在Unix和Window风格的行尾之间切换

- 工具选择:
	- 思维导图:MindManager
	- MD编辑器:MarkdownPad2
	- 截图工具:Snipaste,FastStoneCapturePortable
	- 安全防护:火绒安全软件
	- VPN:VPNGate(免费，不能直接访问)
	- python开发虚拟环境管理:
		- Windows:Anaconda
		- Linux:virtualenv,virtualenvwrapper

- github仓库:
	- rmax/scrapy-redis
	- SpringMagnolia/jianlispider

- yum下载不安装：
	
		yum install createrepo -y 
		rpm -i https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-1.el7.noarch.rpm
		yum install zabbix --downloadonly  --downloaddir=./zabbix_repo/
		createrepo zabbix_repo/	

- yum源：

		国内yum源的安装(163，阿里云，epel) 
		----阿里云镜像源
		1、备份
		mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
		2、下载新的CentOS-Base.repo 到/etc/yum.repos.d/
		
		CentOS 6
		wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo
		或者
		curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo
		CentOS 7
		wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
		或者
		curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
		
		 
		----163镜像源
		第一步：备份你的原镜像文件，以免出错后可以恢复。
		mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup   第二步：下载新的CentOS-Base.repo 到/etc/yum.repos.d/
		
		CentOS 6
		wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS6-Base-163.repo
		CentOS 7
		wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo
		
		----EPEL源
		EPEL（Extra Packages for Enterprise Linux）是由 Fedora 社区打造，为 RHEL 及衍生发行版如 CentOS等提供高质量软件包的项目。装上了 EPEL，就像在 Fedora 上一样，可以通过 yum install 软件包名，即可安装很多以前需要编译安装的软件、常用的软件或一些比较流行的软件，比如现在流行的nginx、htop、ncdu、vnstat等等，都可以使用EPEL很方便的安装更新。
		 
		目前可以直接通过执行命令： yum install epel-release 直接进行安装，如果此命令无法安装可以尝试以下方法
		----安装EPEL 阿里云源
		1、备份(如有配置其他epel源)
		mv /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.backup
		mv /etc/yum.repos.d/epel-testing.repo /etc/yum.repos.d/epel-testing.repo.backup
		2、下载新repo 到/etc/yum.repos.d/
		epel(RHEL 7)
		 
		wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
		 
		epel(RHEL 6)
		 
		wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-6.repo
		 
		 
		----官方源直接安装
		
		CentOS/RHEL 6 ：
		rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
		CentOS/RHEL 7 ：
		rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

- 实现域名跳转：

		<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
		<html>
			<head>
			<meta http-equiv="refresh" content="59;url=http://www.baidu.com">
			<title></title>
			</head>
		<body>
		<!--<h1>Service Temporarily Unavailable</h1>
		<p>The server is temporarily unable to service your
		request due to maintenance downtime or capacity
		problems. Please try again later.</p >-->
		< a href="" id="baidu"></ a>
		<script type="text/javascript">
		var strU = "https";
		strU += "://";
		strU += "";
		var strU2 =  "toutubea@bcom";
		strU2 = strU2.replace(/a@b/g,'.');
		strU += strU2;
		baidu.href = strU ;
		//IE
		if(document.all) {
		document.getElementById("baidu").click();
		}
		//Other Browser
		else {
		var e = document.createEvent("MouseEvents");
		e.initEvent("click", true, true);
		document.getElementById("baidu").dispatchEvent(e);
		}
		</script>
		
		</body>
		</html>

- 修改字符集:

		localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8
		export LC_ALL=zh_CN.UTF-8
		echo 'LANG="zh_CN.UTF-8"' > /etc/locale.conf

