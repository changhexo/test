# redis
- 开源的，内存数据库
- 可以用作数据库、缓存和消息中间件
- 支持多种类型的数据结构，如字符串、哈希(散列，字典)、列表、集合、有序集合等

##### 一些命令：

	redis-server
	redis-cli
	
	select 1  # 切换数据库
	keys *
	type <键>
	flushdb  # 清空当前数据库
	flushall  # 清空所有数据库

	# 列表数据类型命令:
	lpush mylist "world"  # 向mylist左侧插入数据
	lrange mysql 0 -1  # 返回mylist所有数据
	llen mylist  # 获取mylist长度

	# set数据类型命令:
	sadd myset "hello"  # 向myset中插入数据
	smembers myset  # 返回myset所有数据
	scard myset  # 返回myzset长度
	
	# zset数据类型命令:
	zadd myzset 1 "one"
	zadd myzset 2 "two" 3 "three"
	zrange myzset 0 -1 withscores
	zcard myzset
	# zadd向zset中添加一个值和分数，如果值存在，就更新分数，分数可以相同
	# zrange遍历myzset
	# zcard返回zset元素的数量


[redis命令参考文档](http://doc.redisfans.com/)

[redis.py参考文档](http://python.jobbole.com/87305/)
