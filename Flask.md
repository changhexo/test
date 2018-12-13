# Flask
- Flask文档:
	- [中文文档](http://docs.jinkan.org/docs/flask/)
	- [英文文档](http://flask.pocoo.org/docs/)

### 环境准备
这里用的flask==0.11,所以用python2

- 安装依赖：

		yum install mysql-devel python-devel
- 创建虚拟环境：

		mkvirtualenv flask-py2 -p python
- pip freeze列表：

		alembic==0.9.4
		amqp==2.2.2
		billiard==3.5.0.3
		celery==4.1.0
		certifi==2017.7.27.1
		chardet==3.0.4
		Flask==0.10.1
		Flask-Migrate==2.1.0
		Flask-Script==2.0.5
		Flask-Session==0.3.1
		Flask-SQLAlchemy==2.2
		Flask-WTF==0.14.2
		idna==2.5
		itsdangerous==0.24
		Jinja2==2.9.6
		kombu==4.1.0
		Mako==1.0.7
		MarkupSafe==1.0
		MySQL-python==1.2.5
		olefile==0.44
		Pillow==4.2.1
		pycryptodome==3.4.7
		python-alipay-sdk==1.4.0
		python-dateutil==2.6.1
		python-editor==1.0.3
		pytz==2017.3
		qiniu==7.1.4
		redis==2.10.5
		requests==2.18.3
		six==1.10.0
		SQLAlchemy==1.1.12
		urllib3==1.22
		vine==1.1.4
		Werkzeug==0.12.2
		WTForms==2.1
##### 第一个Flask程序:

	# vim hello.py
	# coding:utf-8
	from flask import Flask
	
	# 创建flask应用对象
	app = Flask(__name__)
	
	@app.route("/")
	def index():
		"""定义视图函数"""
		return "hello flask"
	
	
	if __name__ == '__main__':
		# 启动flask程序
		app.run()

	# 运行行flask：
	python hello.py
	# 运行结果：
 	* Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)