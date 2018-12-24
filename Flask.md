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
 	
##### Flask()参数: 

	app = Flask(
		__name__,
		static_url _path="/python",  # 访问静态资源的url前缀，默认值是static
		static_folder="static",  # 静态文件的目录，默认是static
		template_folder="templates",  # 模板文件的目录，默认是templates
	)

#### Flask配置文件参数:
- 从对象中

		class Config(object):
			"""配置参数"""
			DEBUG = True
			ITCAST = "python"
		
		app.config.from_object(Config)
- 从文件中

		# vim config.cfg
		DEBUG = True
		
		app.config.from_pyfile("config.fcg")
- 直接操作config字典

		app.config["DEBUG"] = True

- 配置参数的读取
	- 从全局对象app的config字典中取值
	
			print(app.config.get("ITCAST"))
	- 通过current_app获取参数
	 
			# 需要from flask import current_app
			print(current_app.config.get("ITCAST")) 

#### app.run()参数:

	# 默认host=127.0.0.1, port=5000, debug=False
	app.run(host="192.168.1.1", port=5000)
	app.run(host="0.0.0.0", port=5000.debug=True)  # debug可以在这里设置，其它配置参数不行
#### 视图函数路由规则:

	# 通过url_map查看flask中的路由信息
	pritn(app.url_map)

#### 路由参数（转换器）:
- 默认字符串  # 不加转换器类型，普通字符串规则（不包括 "/"）

		@app.route("/goods/<goods_id>")
		def goods_detail(goods_id):
	    	"""定义的视图函数"""
	    	return "goods detail page %s" % goods_id
- int  # 整型

		@app.route("/goods/<int: goods_id>")
		def goods_detail(goods_id):
	    	"""定义的视图函数"""
	    	return "goods detail page %s" % goods_id
- float  # 浮点型
- path  # 字符串类型，同默认规则，但包括 "/"
- 自定义类型

		# 1.自定义转换器，需要from werkzeug.routing import BaseConverter
		class RegexConverter(BaseConverter):
		    """自定义转换器，万能转换器"""
		    def __init__(self, url_map, regex):
		        # 调用父类的初始化方法
		        super(RegexConverter, self).__init__(url_map)
		        # 将正则表达式的参数保存到对象的属性中，flask会去使用这个属性来进行路由的正则匹配
		        self.regex = regex

			def to_python(self, value):  # 父类里定义了to_python当你不做转换时，这里可以不定义
				# value是在路径进行正则表达式匹配的时候提取的参数
				return value
	
			def to_url(self, value):  # 父类里定义了to_python当你不做转换时，这里可以不定义
				"""使用url_for的时候被调用"""
				return value

		# 2. 将自定义的转换器添加到flask的应用中
		app.url_map.converters["re"] = RegexConverter

		# 3.使用转换器 http://127.0.0.1:5000/send/13800000000
		@app.route("/send/<re(r'1[34578]\d{9}'):mobile_num>")  # 默认会调用to_python()
		def send_sms(mobile_num):  # mobile_num的值是to_python的返回值
		    return "send sms to %s" % mobile_num

		@app.route("/index")
		def index():  # 需要from flask import url_for, redirect
			url = url_for("send_sms", mobile_num="13800000000")  # 默认会调用to_url()
			return redirect(url)

#### from flask import request

	# coding:utf-8

	from flask import Flask, request
	
	
	app = Flask(__name__)

	@app.route("/index", methods=["GET", "POST"])
	def index():
		# request中包含了前端发送过来的所有请求数据
		# 通过request.form可以直接提取请求体中的表单格式的数据，是一个类字典的对象
		name = request.form.get("name", "zhangsan")  # get方法只能拿到同名参数的第一个
		age = request.form.get("age", 18)
		print(request.data)
		name_list = request.form.getlist("name")  # 获取同名的多个参数，返回一个列表
		return "hello name=%s, age=%s" % (name, age)


	if __name__ == "__main__":
		app.run(debug=True)

- request.form 获取表单数据
	- request.form.getlist("键名")  # 取同名属性的多个值，get只能取一个
- request.data 获取原始请求休
- request.args 获取查询字符串(url中的参数)

- 常见属性
	- data
		- 返回类型：*
		- 记录请求的数据，并转换为字符串
	- form
		- 返回类型：MultiDict
		- 记录请求中的表单数据
	- args
		- 返回类型：MultiDict
		- 记录请求中的查询字符串(即url参数)
	- cookies
		- 返回类型：Dict
		- 记录请求中的cookie信息
	- headers
		- 返回类型：EnvironHeaders
		- 记录请求中的报文头
	- method
		- 返回类型：GET/POST
		- 记录请求使用的HTTP方法
	- url
		- 返回类型：String
		- 记录请求的url地址
	- files
		- 返回类型：*
		- 记录请求上传的文件

#### 上传文件

	@app.route("/upload", method=["POST"])
	def upload():
		"""接收前端传过来的文件"""
		file_obj = request.files.get("pic")
		if file_obj is None:
			return "未上传文件"
		# # 将文件保存到本地
		# # 1.创建文件:
		# with open("./demo.jpg", "wb") as f:
			# # 2.向文件中写内容
			# f.write（file_obj.read()）
		# return "上传成功"

		# 直接使用上传的文件对象:
		file_obj.save("./demo1.jpg")
		return "上传成功"

#### abort函数
	abort(404)
	abort(Response("login failed"))
#### 自定义错误处理方法
	@app.errorhandler(404)
	def handler_404_error(err):
		"""自定义错误处理"""
		return u"出现了404错误，错误信息: %s" % err
#### 自定义响应信息
	@app.route("/index")
	def index():
		# 1.使用无组
		# return "index page", 400, [("Itcast", "python"), ("City", "shenzhen")]
		# return "index page", 400, {"Itcast1": "python1", "City1": "shenzhen1"}
		# return "index page", "666 itcast", {"Itcast1": "python1", "City1": "shenzhen1"}
		# return "index page", "666 itcast"
	
		# 2.使用maake_response构造响应信息
		resp = make_response("index page2")
		resp.status = "999 itcast" # 设置状态码
		resp.headers["city"] = "shenzhen" # 设置响应头
		return resp
#### 返回json数据
	@app.route("/index")
	def index():
		# json就是字符串
		data = {
			"name": "python",
			"age": 18
		}
		# # 需要 import json
		# # json.dumps(dict) 将python字典转换为json字符串
		# # json.loads(str) 将字符串转换成python中的字典
		# json_str = json.dumps(data)
		# return json_str, 200, {"Content-Type": "application/json"}
		# # 需要 from flask import jsonify
		# # jsonify帮助转换为json数据，并设置响应头为: "Content-Type": "application/json"
		# return jsonify(data)
		return jsonify(city="shenzhen", country= "China")
#### cookie
	@app.route("/set_cookie")
	def set_cookie():
		resp = make_response("success")
		# 设置cookie，默认是临时cookie，关闭浏览器就失效
		resp.set_cookie("Itcast": "python")
		resp.set_cookie("Itcast1": "python1", max_age=3600)
		# 通过响应头设置cookie
		resp.headers["Set-Cookie"] = "Itcast2=python2; Max-Age: 3600"
		return resp
	
	@app.route("/get_cookie")
	def get_cookie():
		# 获取cookie
		c = request.cookies.get("Itcast")
		return c
	
	@app.route("/delete_cookie")
	def delete_cookie():
		resp = make_response("del cookie")
		# 删除cookie，实际上修改cookie过期时间
		resp.delete_cookies("Itcast1")
		return c

#### session
	# flask的session需要用到的密钥字符串
	app.config["SECRET_KEY"] = "fagfeiaghfiuawbfiaubf"
	
	@app.route("/index")
	def index():
		# 获取seesion数据, 需要 from flask import session
		name = seesion.get("name")
		return "hello %s" % name
	
	@app.route("/login")
	def login():
		# 设置session数据, 需要 from flask import session
		session["name"] = "python"
		session["mobile"] = "13811111111"
		return "login success"