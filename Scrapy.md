# Scrapy框架

- 模块：
- 框架：包含模块

Scrapy使用了**Twisted**(扭曲)**异步**网络框架，可以加快下载速度

同步/异步  阻塞/非阻塞

### Scrapy工作流程：
![](./images/scrapy_1.png)
----
![](./images/scrapy_2.png)
----
![](./images/scrapy_3.png)

### Scrapy安装：

Linux 下直接：

	pip install scrapy

windows下安装会报以下错误：
  
  	error: Microsoft Visual C++ 14.0 is required. Get it with "Microsoft Visual C++ Build Tools": http://landinghub.visualstudio.com/visual-cpp-build-tools
  - 错误提示的链接已经失效，需要去微软下载，整个下载 **1G** 多
  - 解决方案1：（但是并没成功）
	1. 从此链接下载Microsoft Visual C ++生成工具：https：//visualstudio.microsoft.com/downloads/
	2. 向下滚动到 **用于Visual Studio 2017的工具**
	3. 运行安装程序
	4. 选择：**工作负载**----**Visual C ++构建工具**
	5. 安装选项：仅选择“Windows 10 SDK”（假设计算机是Windows 10）
  - 解决方案2：
    1. 安装Anaconda（600多M）
    2. conda install -c conda-forge scrapy

----

### Scrapy 入门：

1. 新建scrapy项目：

		scrapy startproject <项目名称>

		scrapy startproject mySpider
		New Scrapy project 'mySpider', using template directory 'C:\\ProgramData\\Anaconda3\\lib\\site-packages\\scrapy\\templates\\project', created in:
		    C:\Users\Administrator\PycharmProjects\mySpider
		
		You can start your first spider with:
		    cd mySpider
		    scrapy genspider example example.com
2. 生成一个爬虫：

		cd <项目目录>
		scrapy genspider <爬虫名称> <'允许范围'>

		cd mySpider
		scrapy genspider baidu "baidu.com"
		Created spider 'baidu' using template 'basic' in module:
		  mySpider.spiders.baidu

  - 生成的文件目录树

			[root@localhost mySpider]# tree
			.
			├── mySpider
			│   ├── __init__.py
			│   ├── items.py
			│   ├── middlewares.py
			│   ├── pipelines.py
			│   ├── __pycache__
			│   │   ├── __init__.cpython-36.pyc
			│   │   └── settings.cpython-36.pyc
			│   ├── settings.py
			│   └── spiders
			│       ├── baidu.py
			│       ├── __init__.py
			│       └── __pycache__
			│           └── __init__.cpython-36.pyc
			└── scrapy.cfg
3. 提取数据
  - 完善spider, 使用xpatht等方法
  
			class ItcastSpider(scrapy.Spider):
			    name = 'itcast'
			    allowed_domains = ['itcast.cn']
			    start_urls = ['http://www.itcast.cn/channel/teacher.shtm']
			
			    def parse(self, response):
			        li_list = response.xpath("//div[@class='tea_con']//li")
			        for li in li_list:
						item = {}
						item['name'] = li.xpath(".//h3/text()").extract_first()
						# extract()[0] 取第一个元素，如果没有则会报错
						# extract_first() 取第一个元素，如果没有则会返回 None
						# must return Request, BaseItem, dict or None
						yield item  # 减少内存占用
4. 保存数据
  - pipeline中保存数据

			class MyspiderPipeline(object):
			    def process_item(self, item, spider):
			        print(item)
			        return item

  - 编辑settings.py启用pipeline(取消注释)
  
			ITEM_PIPELINES = {
			   'mySpider.pipelines.MyspiderPipeline': 300,
				# 可以定义多个pipeline去接收item，数字越小越先接收
				'mySpider.pipelines.MyspiderPipeline1': 301，
			}
5. 启动爬虫：

		scrapy crawl <爬虫名称>
	
		scrapy crawl baidu
  - 编辑settings.py定义日志级别，使输出更干净：

			LOG_LEVEL = "WARNING"

### pipeline
为什么要多个pipeline

  - 爬虫项目，多个爬虫
  - 定义多个pipeline去处理，虽然一个pipeline可以处理，但效率会低

实现：

  - 给item额外添加key:vaalue
  - 在pipeline去做if判断，也可以用spider.name去做判断

### logging模块
使用logging.warning()去打印输出

  - 生成时间
  - 显示来自哪个爬虫
  
		import logging
		logger = logging.getLogger(__name__)
		logger.warning(item)
  - 日志保存到本地,编辑settings.py
  
  		LOG_FILE = "./spider.log"
  - 普通py文件定义日志存储
  
		import logging

		logging.basicConfig(
			level=logging.INFO,
			format = '%(asctime)s [%(filename)s line:%(lineno)d] %(levelname)s: %(message)s',
			# 格式可以自行百度
			datefmt = '%Y-%m-%d %H:%M:%S',
			# 日志存储位置
			filename = 'try_log.log',
			# 日志打开方式，w 再次运行会覆盖之前产生的日志，a 追加
			filemode = 'w',
		)
		logger = logging.getLogger(__name__)

		if __name__ == '__main__':
			logger.info("this is info log")

		运行结果：
		2018-12-07 15:13:43 [try_log.py line:11] INFO: this is info log
  

