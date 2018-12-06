# MongoDB

- 关于数据库的命令：

		show dbs
		use dn_name
		db
		db.dropDatabase()


- 关于集合的命令：

		db.createCollection(name,options)
		db.createCollection("stu")
		db.createCollection("sub",{capped:true,size:10})
	
		参数capped:默认值为false，表示不设置上限
		参数size：当capped值为true时，需要指定参数，表示限大小，当文档达到上限时，会将之前的数据覆盖，单位:字节
	
		查看集合：
		show collections
		删除集合：
		db.集合名称.drop()

- 数据类型：
	- Object ID: 文档ID
	- String
	- Boolean
	- Integer
	- Double
	- Arrays
	- Object
	- Null
	- Timestamp
	- Date

	创建日期语句： 参数格式 YYYY-MM-DD

		new Date("2018-12-05")

	每个文档都有一个属性，为 _id，保证每个文档的唯一性
	可以自己去设置 _id 插入文档，如果没有提供，那么MongoDB为每个文档提供一个独特的ID，类型为ObjectID

	ObjectID是一个12字节的十六进制数：

		- 前4个字节为当前--时间戳
		- 接下来3个字节的--机器ID
		- 接下来2个字节中MongoDB的--服务进程id
		- 最后3个是简单--增量值

- 插入数据：

		db.test1.insert({"name": "xiaowang", "age": 10})
		db.rest1.find()
		{ "_id" : ObjectId("5c0878c216c6a65880b01ffb"), "name" : "xiaowang", "age" : 10 }
	
	
		db.test1.insert({name:"xiaoli",age:19})
		> db.test1.find()
		{ "_id" : ObjectId("5c0878c216c6a65880b01ffb"), "name" : "xiaowang", "age" : 10 }
		{ "_id" : ObjectId("5c087ad216c6a65880b01ffd"), "name" : "xiaoli", "age" : 19 }

- 其它操作：

		db.集合名称.save()  # 可以修改数据
		db.集合名称.update({查询条件},{修改后的内容})  # 将所有内容替换成修改后的
		db.集合名称.update({查询条件},{$set:{修改后的内容}})  # 修改指定的内容，其余保留
		db.集合名称.update({查询条件},{$set:{修改后的内容}},{multi:true})  # 修改匹配到所有数据(更新多条)
		db.集合名称.remove({查询条件})  # 删除符合条件的所有数据
		db.集合名称.remove({查询条件},{justOne:true})  # 删除符合条件的一条数据
		
		db.集合名称.find({查询条件})
		db.集合名称.findOne({查询条件})

- 比较运算符：

		等于，默认是等于判断，没有运算符
		小于，$lt
		小于等于，$lte
		大于，$gt
		大于等于，$gte
		不等于：$ne
		db.test1.find({age:{$gte:18}})

- pretty()  # 查询结果格式化

		db.test1.find({age:{$gte:18}}).pretty()
		{
		        "_id" : ObjectId("5c0878c216c6a65880b01ffb"),
		        "name" : "xiaowang",
		        "age" : 10
		}
		{
		        "_id" : ObjectId("5c087ad216c6a65880b01ffd"),
		        "name" : "xiaoli",
		        "age" : 19
		}

- 范围运算符：
- 
		$in
		$nin
		db.test1.find({age:{$in:[18,28,38]}})

- 逻辑运算：
	- 写入多个查询条件(就是and)
 
 			db.test1.find({age:18,gender:true})

	- $or
	
			db.test1.find({$or:[{age:18},{genger:true}]})

- 正则表达式：
	- //
	
			/^abc/
	- $regex
	
			{$regex:"7890$"}

- limit和skip

		db.test1.find().skip(2).limit(2)
			推荐先skip后limit

- 自定义相询(js)：

		db.test1.find({
			$where:function(){
				return this.age>9;
			}
		})

- 数据过滤：
	- 投影(选择返回结果的字段)：
	
			db.test1.find({$or:[{age:18},{genger:true}]},{name:1,_id:0})  
			# 需要什么字段就写"1"，"_id"默认显示，不显示写"0",其它字段，不显示不写就行，写"0"会报错

	- 排序：
	
			db.集合名称.find({查询条件}).sort()
			sort({age:1})  # 升序
			sort({age:-1})  # 降序
			多字段排序：
				sort({age:1},{gender:-1})

	- 统计：
	
			db.集合名称.find({查询条件}).count()

	- 去重：
	
			distinct()
			db.集合名称.distinct("去重字段",{条件})
			可以不加条件
			db.test1.distinct("name",{age:{$gt:10}})


### 数据备份与恢复：
	mongodump -h dbhost -d dbname -o dbdirectory
	-h 服务器地址，也可以指定端口号
	-d 需要备份的数据库的名称
	-o 数据备份的存储路径
	mongodump -h 192.168.1.100:27017 -d test1 -o ~/dbbkp

	mongorestore -h dbhost -d dbname --dir dbdirectory
	-h 服务器地址
	-d 需要恢复的数据库实例
	--dir 备份数据所在位置

	mongorestore -h 192.168.1.100:27017 -d test2 --dir ~/dbbkp/test1


### 聚合aggregate:

	db.集合名称.aggreate({管道:{表达式}})

	常用管道命令;
		$group  # 将集合中的文档分组
		$match  # 过滤数据，只输出符合条件的文档
		$project  # 修改输出文档结构，如：重命名，增加、删除字段，创建计算结果
		$sort  # 将输入文档排序后输出
		$limit  # 限制聚合管道返回的文档数据
		$skip  # 路过指定数量的文档，并返回余下的文档
		$unwind  # 将数组类型的字段进行拆分

	表达式：
		处理输入文档并输出
		语法：表达式：'列名'
		常用表达式：
			$sum  # 计算总和，$sum:1 表示以一倍计数
			$avg  # 平均值
			$min  # 最小值
			$max  # 最大值
			$push  # 在结果文档中插入值到一个数据中
			$first  # 根据资源文档的排序获取第一个文档数据
			$last  # 根据资源文档的排序获取最后一个文档数据


##### 准备数据

	use stu
	db.stu.insert({name:"郭靖",hometown:"蒙古",age:20,gender:true})
	db.stu.insert({name:"黄蓉",hometown:"桃花岛",age:18,gender:false})
	db.stu.insert({name:"华筝",hometown:"蒙古",age:18,gender:false})
	db.stu.insert({name:"黄药师",hometown:"桃花岛",age:40,gender:true})
	db.stu.insert({name:"段誉",hometown:"大理",age:16,gender:true})
	db.stu.insert({name:"段王爷",hometown:"大理",age:45,gender:true})
	db.stu.insert({name:"洪七公",hometown:"华山",age:18,gender:true})

	db.area.insert({country:"CN",province:"Beijing",userid:"a"})
	db.area.insert({country:"CN",province:"Beijing",userid:"b"})
	db.area.insert({country:"CN",province:"Beijing",userid:"a"})
	db.area.insert({country:"CN",province:"Shanghai",userid:"c"})
	db.area.insert({country:"UK",province:"AK",userid:"d"})


### 管道命令:
- $group---分组

		db.stu.aggregate({
			$group:{_id:"$gender",count:{$sum:1},avg_age:{$avg:"$age"}}
		})
		
		db.stu.aggregate({
			$group:{_id:"$hometown",mean_age:{$avg:"$age"}}
		})
		
		db.stu.aggregate({
			$group:{_id:null,count:{$sum:1},avg_age:{$avg:"$age"}}
		})


  - 利用$group去重：

			db.area.aggregate(
				{$group:{_id:{country:"$country",province:"$province",userid:"$userid"}}}
				)

  - 字典嵌套字典取值：

			db.area.aggregate(
				{$group:{_id:{country:"$country",province:"$province",userid:"$userid"}}},
				{$group:{_id:{country:"$_id.country",province:"$_id.province"},count:{$sum:1}}},
				{$project:{country:"$_id.country",province:"$_id.province",count:1,_id:0}}
				)

- $project----修改字段名

		db.stu.aggregate(
			{$group:{_id:"$gender",count:{$sum:1},avg_age:{$avg:"$age"}}},
			{$project:{gender:"$_id",count:"$count",avg_age:"$avg_age"}}
			)
		
		db.stu.aggregate(
			{$group:{_id:"$gender",count:{$sum:1},avg_age:{$avg:"$age"}}},
			{$project:{gender:"$_id",count:"$count",avg_age:"$avg_age",_id:0}}
			)

- $matc----过滤

		db.stu.aggregate(
			{$match:{age:{$gt:20}}},
			{$group:{_id:"$gender",count:{$sum:1}}},
			{$project:{gender:"$_id"}}
			)

		db.stu.aggregate(
			{$match:{age:{$gt:17}}},
			{$group:{_id:"$gender",count:{$sum:1}}},
			{$project:{gender:"$_id",count:1,_id:0}}
			)

		db.stu.aggregate(
			{$match:{age:{$gt:17}}},
			{$group:{_id:"$gender",count:{$sum:1}}},
			{$project:{gender:"$_id",count:1,_id:0}}
			).pretty()

- $sort----排序
	
		db.stu.aggregate(
			{$group:{_id:"$gender",count:{$sum:1}}},
			{$project:{gender:"$_id",count:1,_id:0}},
			{$sort:{count:-1}}
			)

- $limit

		db.stu.aggregate({$limit:2})

- $skip

		db.stu.aggregate({$skip:2})
		db.stu.aggregate({$skip:2},{$limit:2})  # 注意顺序先skip再limit（效率会高）

- $unwind----拆分

		db.t1.insert({item:"T-shirt",size:["S","M","L"]})
		
		db.t1.aggregate({$unwind:"$size"})
		{ "_id" : ObjectId("5c08c29b9fe1ac9ca5d1f332"), "item" : "T-shirt", "size" : "S" }
		{ "_id" : ObjectId("5c08c29b9fe1ac9ca5d1f332"), "item" : "T-shirt", "size" : "M" }
		{ "_id" : ObjectId("5c08c29b9fe1ac9ca5d1f332"), "item" : "T-shirt", "size" : "L" }

		db.t1.find()  # 存储的数据结构没有变
		{ "_id" : ObjectId("5c08c29b9fe1ac9ca5d1f332"), "item" : "T-shirt", "size" : [ "S", "M", "L" ] }

		db.t1.aggregate(
			{$unwind:"$size"},
			{$group:{_id:"$item",count:{$sum:1}}},
			{$project:{item:"$_id",conut_size:"$count",_id:0}}
			)
		
		db.t1.aggregate(
			{$unwind:"$size"},
			{$group:{_id:null,conut_size:{$sum:1}}}
			)

		拆分后有空值的保留：
		db.t2.aggregate(
			{$unwind:{
				path:"$size",
				preseerveNullAndEmptyArrays:true
			}}
			)
		
		db.t1.aggregate(
			{$unwind:{path:"$size"}}
			)


- 索引:

	插入100万条数据：

		for(i=0;i<1000000;i++){db.shiwan.insert({name:"test"+i,age:i})}

  - 创建索引:`db.集合名称.ensureIndex({属性:1})  # 1表示升序，-1表示降序，这个值只有在使用sort排序时，才会有影响`
	
			db.shiwan.ensureIndex({name:1})
			{
			        "createdCollectionAutomatically" : false,
			        "numIndexesBefore" : 1,
			        "numIndexesAfter" : 2,
			        "ok" : 1
			}

	创建索引-**前**-的查询状态("executionTimeMillis"字段):

		db.shiwan.find({name:"test999999"}).explain("executionStats")
		{
		        "queryPlanner" : {
		                "plannerVersion" : 1,
		                "namespace" : "stu.shiwan",
		                "indexFilterSet" : false,
		                "parsedQuery" : {
		                        "name" : {
		                                "$eq" : "test999999"
		                        }
		                },
		                "winningPlan" : {
		                        "stage" : "COLLSCAN",
		                        "filter" : {
		                                "name" : {
		                                        "$eq" : "test999999"
		                                }
		                        },
		                        "direction" : "forward"
		                },
		                "rejectedPlans" : [ ]
		        },
		        "executionStats" : {
		                "executionSuccess" : true,
		                "nReturned" : 1,
		                "executionTimeMillis" : 374,
		                "totalKeysExamined" : 0,
		                "totalDocsExamined" : 1000000,
		                "executionStages" : {
		                        "stage" : "COLLSCAN",
		                        "filter" : {
		                                "name" : {
		                                        "$eq" : "test999999"
		                                }
		                        },
		                        "nReturned" : 1,
		                        "executionTimeMillisEstimate" : 337,
		                        "works" : 1000002,
		                        "advanced" : 1,
		                        "needTime" : 1000000,
		                        "needYield" : 0,
		                        "saveState" : 7825,
		                        "restoreState" : 7825,
		                        "isEOF" : 1,
		                        "invalidates" : 0,
		                        "direction" : "forward",
		                        "docsExamined" : 1000000
		                }
		        },
		        "serverInfo" : {
		                "host" : "Django",
		                "port" : 27017,
		                "version" : "4.0.4",
		                "gitVersion" : "f288a3bdf201007f3693c58e140056adf8b04839"
		        },
		        "ok" : 1
		}
	创建索引-**后**-的查询状态("executionTimeMillis"字段):

		db.shiwan.find({name:"test999999"}).explain("executionStats")
		{
		        "queryPlanner" : {
		                "plannerVersion" : 1,
		                "namespace" : "stu.shiwan",
		                "indexFilterSet" : false,
		                "parsedQuery" : {
		                        "name" : {
		                                "$eq" : "test999999"
		                        }
		                },
		                "winningPlan" : {
		                        "stage" : "FETCH",
		                        "inputStage" : {
		                                "stage" : "IXSCAN",
		                                "keyPattern" : {
		                                        "name" : 1
		                                },
		                                "indexName" : "name_1",
		                                "isMultiKey" : false,
		                                "multiKeyPaths" : {
		                                        "name" : [ ]
		                                },
		                                "isUnique" : false,
		                                "isSparse" : false,
		                                "isPartial" : false,
		                                "indexVersion" : 2,
		                                "direction" : "forward",
		                                "indexBounds" : {
		                                        "name" : [
		                                                "[\"test999999\", \"test999999\"]"
		                                        ]
		                                }
		                        }
		                },
		                "rejectedPlans" : [ ]
		        },
		        "executionStats" : {
		                "executionSuccess" : true,
		                "nReturned" : 1,
		                "executionTimeMillis" : 1,
		                "totalKeysExamined" : 1,
		                "totalDocsExamined" : 1,
		                "executionStages" : {
		                        "stage" : "FETCH",
		                        "nReturned" : 1,
		                        "executionTimeMillisEstimate" : 0,
		                        "works" : 2,
		                        "advanced" : 1,
		                        "needTime" : 0,
		                        "needYield" : 0,
		                        "saveState" : 0,
		                        "restoreState" : 0,
		                        "isEOF" : 1,
		                        "invalidates" : 0,
		                        "docsExamined" : 1,
		                        "alreadyHasObj" : 0,
		                        "inputStage" : {
		                                "stage" : "IXSCAN",
		                                "nReturned" : 1,
		                                "executionTimeMillisEstimate" : 0,
		                                "works" : 2,
		                                "advanced" : 1,
		                                "needTime" : 0,
		                                "needYield" : 0,
		                                "saveState" : 0,
		                                "restoreState" : 0,
		                                "isEOF" : 1,
		                                "invalidates" : 0,
		                                "keyPattern" : {
		                                        "name" : 1
		                                },
		                                "indexName" : "name_1",
		                                "isMultiKey" : false,
		                                "multiKeyPaths" : {
		                                        "name" : [ ]
		                                },
		                                "isUnique" : false,
		                                "isSparse" : false,
		                                "isPartial" : false,
		                                "indexVersion" : 2,
		                                "direction" : "forward",
		                                "indexBounds" : {
		                                        "name" : [
		                                                "[\"test999999\", \"test999999\"]"
		                                        ]
		                                },
		                                "keysExamined" : 1,
		                                "seeks" : 1,
		                                "dupsTested" : 0,
		                                "dupsDropped" : 0,
		                                "seenInvalidated" : 0
		                        }
		                }
		        },
		        "serverInfo" : {
		                "host" : "Django",
		                "port" : 27017,
		                "version" : "4.0.4",
		                "gitVersion" : "f288a3bdf201007f3693c58e140056adf8b04839"
		        },
		        "ok" : 1
		}

  - 查看索引:`db.集合名称.getIndexes()`
  
			db.shiwan.getIndexes()
			[
			        {
			                "v" : 2,
			                "key" : {
			                        "_id" : 1
			                },
			                "name" : "_id_",
			                "ns" : "stu.shiwan"
			        },
			        {
			                "v" : 2,
			                "key" : {
			                        "name" : 1
			                },
			                "name" : "name_1",
			                "ns" : "stu.shiwan"
			        }
			]

  - 删除索引:`db.集合名称.dropIndex("索引名称")`
    - 两种方式:
      - 通过name删除:`db.shiwan.dropIndex("name_1")`
      - 通过key删除:`db.shiwan.dropIndex({name:1})`

  - 创建唯一索引:`db.shiwan.ensureIndex({name:1},{unique:true})`
     - 爬虫数据去重，建立关键字段(一个或者多个)唯一索引，实现**增量式爬虫**
     - 根据url地址去重
         - 使用场景
         - url地址对应的数据不会变的情况，url能够唯一判别一条数据的情况
         - 思路
             - url存在redis中
             - 拿到url地址，判断url地址在redis的集合中是否存在
                 - 存在，说明url被请求过，不再请求
                 - 不存在，url地址没有被 请求过，请求，并把该地址存入redis中
			- 布隆过滤器
			  - 使用多个加密算法加密url地址，得到多个值
			  - 往对应值的位置结果设置为1
			  - 新来一个url地址，一样通过加密算法生成多个值
			  - 如果对应位置的值全为1，说明这个url地址已经抓过
			  - 否则，没有抓过，就把对应位置的值设置为1
		- 根据数据本身去重
		  - 选择特定字段，使用加密算法(md5, sha1)将字段加密生成字符串，存入redis中
		  - 后续新来一条数据，同样的方法加密，如果得到的字符串在redis中存在，说明数据存在，对数据更新，否则说明不存在，直接插入

  - 创建联合索引:`db.shiwan.ensureIndex({name:1,age:1})`


### 练习：

	db.tv1.aggregate(
		{$project:{title:1,_id:0,count:"$rating.count",tate:"$rating.value",country:"$tv_category"}}
	)

	db.tv1.aggregate(
		{$project:{title:1,_id:0,count:"$rating.count",tate:"$rating.value",country:"$tv_category"}},
		{$group:{_id:"$country",count:{$sum:1}}}
	)

	db.tv1.aggregate(
		{$project:{title:1,_id:0,count:"$rating.count",rate:"$rating.value",country:"$tv_category"}},
		{$match:{rate:{$gt:8}}},
		{$group:{_id:"$country",count:{$sum:1}}}
	)

	db.tv1.aggregate(
		{$project:{title:1,_id:0,count:"$rating.count",rate:"$rating.value",country:"$tv_category"}},
		{$match:{rate:{$gt:8}}},
		{$group:{_id:"$country",count:{$sum:1}}},
		{$project:{_id:0,country:"$_id",count:1}}
	)

# pymongo的操作：
	from pymongo import MongoClient

	client = MongoClient()
	collection = client["test1"]["pymongo_test"]  # test1是数据库，pymongo_test是集合
	t = collection.find_one({"name": "test0"})
	print(t)

	运行结果：
	{'_id': ObjectId('5c09111759cb62107cacf4d1'), 'name': 'test0'}

==============================

	from pymongo import MongoClient
	

	# 实例化
	# client = MongoClient(host="127.0.0.1", post=27017)
	client = MongoClient()
	collection = client["test1"]["pymongo_test"]
	
	# 数据插入:
	# data_list = [{'name': 'test{}'.format(i)} for i in range(10)]
	# collection.insert_many(data_list)
	
	# collection.insert()  # 插入单条数据
	# collection.insert_many()  # 插入多条数据
	
	# 数据查询:
	# t = collection.find_one({"name": "test0"})
	# print(t)
	# t = collection.find({"name": "test0"})
	# t = list(t)  # t是cursor对象,只能遍历一次,转换成list后就可以多次遍历
	# for i in t:
	#     print(i)
	# for j in t:
	#     print(j, '*'*10)
	
	# 数据更新
	# collection.update_one({'name': 'test0'}, {'$set': {'name': 'test000'}})  # 更新一条
	# collection.update_many({'name': 'test1'}, {'$set': {'name': 'test111'}})  # 更新全部
	
	# 数据删除：
	# collection.delete_one({'name': 'test2'})  # 删除一条
	# collection.delete_many({'name': 'test3'})  # 删除全部
