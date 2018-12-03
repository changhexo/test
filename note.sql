-- 查看数据库
show databases;

-- 查看数据版本
select version();

-- 查看数据当前时间
select now();

-- 创建数据库
create database python_01;
create database python_02 charset=utf8;

show create database python_01;

drop database python_02;

-- 进入数据库
use python_01;

-- 查看当前所在数据库
select database();

-- 查看当前数据库的数据表
show tables;

-- 创建数据表
create table class(id int, name varchar(30));

-- 查看表结构
desc class;

create table xxx(id int primary key not null auto_increment, name varchar(30));

create table student(
	id int unsigned not null auto_increment primary key,
	name varchar(30),
	age tinyint unsigned,
	high decimal(5,2),
	gender enum('男', '女', '保密') default '保密',
	cls_id int unsigned
);

-- 插入数据
insert into student values(1, '老王', 18, 188.88, '男', 1);

create table classes(
	id int unsigned not null auto_increment primary key, 
	name varchar(30)
);

insert into classes values(1, 'python班');

-- 添加表字段
alter table student add brithday datetime;

-- 修改字段属性
alter table student modify brithday date;

-- 修改字段属性和字段名
alter table student change brithday brith date default '1990-01-01';

insert into student values(0, '老王', 26, 168.88, '男', 1, '1992-1-1');

desc student;
/*
+--------+----------------------------+------+-----+------------+----------------+
| Field  | Type                       | Null | Key | Default    | Extra          |
+--------+----------------------------+------+-----+------------+----------------+
| id     | int(10) unsigned           | NO   | PRI | NULL       | auto_increment |
| name   | varchar(30)                | YES  |     | NULL       |                |
| age    | tinyint(3) unsigned        | YES  |     | NULL       |                |
| high   | decimal(5,2)               | YES  |     | NULL       |                |
| gender | enum('男','女','保密')     | YES  |     | 保密       |                |
| cls_id | int(10) unsigned           | YES  |     | NULL       |                |
| brith  | date                       | YES  |     | 1990-01-01 |                |
+--------+----------------------------+------+-----+------------+----------------+
*/

/*
插入数据中的细节
default 代表默认值
enum 类型中，按顺序可以用数字代替
*/

-- 部分字段插入
insert into student(name, gender) values('李四', 1);

-- 一次插入多条记录
insert into student(name, gender) values('王五', 1), ('刘六', 1);

insert into student values(0, '田七', 28, 168.88, '男', 1, default), (0, '张三', 28, 168.88, '男', 1, default);

-- 删除数据表
drop table xxx;

-- 修改记录内容
update student set gender=1 where id=3;
update student set age=23, gender=1 where name='老李';

-- 查询记录
select * from student where name='老王';

-- 查询结果只显示一条
select * from student where name='老王' limit 1;

select * from student where id>4;

-- 重命名字段显示（不会修改数据里的内容）
select name as "名字" from student;
/*
+--------+
| 名字   |
+--------+
| 老王   |
| 老李   |
| 老刘   |
| 老王   |
| 老王   |
| 李四   |
| 王五   |
| 刘六   |
| 田七   |
| 张三   |
+--------+
*/

select id as "序号", name as "名字", brith as "生日" from student;
/*
+--------+--------+------------+
| 序号   | 名字   | 生日       |
+--------+--------+------------+
|      1 | 老王   | NULL       |
|      2 | 老李   | 1990-07-01 |
|      3 | 老刘   | 1990-05-08 |
|      4 | 老王   | 1992-01-01 |
|      5 | 老王   | 1990-01-01 |
|      6 | 李四   | 1990-01-01 |
|      7 | 王五   | 1990-01-01 |
|      8 | 刘六   | 1990-01-01 |
|      9 | 田七   | 1990-01-01 |
|     10 | 张三   | 1990-01-01 |
+--------+--------+------------+
*/

-- 删除数据
delete from student /* 没有 where 条件就相当于清空表 */
delete from student where name='老王';

-- 逻辑删除(数据无价，不要物理删除)
alter table student add is_delete bit default 0;
/*
mysql> select * from student where is_delete=0;
+----+--------+------+--------+--------+--------+------------+-----------+
| id | name   | age  | high   | gender | cls_id | brith      | is_delete |
+----+--------+------+--------+--------+--------+------------+-----------+
|  2 | 老李   |   23 | 167.34 | 男     |      2 | 1990-07-01 |           |
|  3 | 老刘   |   28 | 177.34 | 男     |      1 | 1990-05-08 |           |
|  6 | 李四   | NULL |   NULL | 男     |   NULL | 1990-01-01 |           |
|  7 | 王五   | NULL |   NULL | 男     |   NULL | 1990-01-01 |           |
|  8 | 刘六   | NULL |   NULL | 男     |   NULL | 1990-01-01 |           |
|  9 | 田七   |   28 | 168.88 | 男     |      1 | 1990-01-01 |           |
| 10 | 张三   |   28 | 168.88 | 男     |      1 | 1990-01-01 |           |
+----+--------+------+--------+--------+--------+------------+-----------+
7 rows in set (0.00 sec)

mysql> select * from student where is_delete=1;
Empty set (0.00 sec)

*/
update student set is_delete=1 where id=9;
/*
mysql> select * from student where is_delete=1;
+----+--------+------+--------+--------+--------+------------+-----------+
| id | name   | age  | high   | gender | cls_id | brith      | is_delete |
+----+--------+------+--------+--------+--------+------------+-----------+
|  9 | 田七   |   28 | 168.88 | 男     |      1 | 1990-01-01 |          |
+----+--------+------+--------+--------+--------+------------+-----------+
1 row in set (0.00 sec)

mysql> select * from student where is_delete=0;
+----+--------+------+--------+--------+--------+------------+-----------+
| id | name   | age  | high   | gender | cls_id | brith      | is_delete |
+----+--------+------+--------+--------+--------+------------+-----------+
|  2 | 老李   |   23 | 167.34 | 男     |      2 | 1990-07-01 |           |
|  3 | 老刘   |   28 | 177.34 | 男     |      1 | 1990-05-08 |           |
|  6 | 李四   | NULL |   NULL | 男     |   NULL | 1990-01-01 |           |
|  7 | 王五   | NULL |   NULL | 男     |   NULL | 1990-01-01 |           |
|  8 | 刘六   | NULL |   NULL | 男     |   NULL | 1990-01-01 |           |
| 10 | 张三   |   28 | 168.88 | 男     |      1 | 1990-01-01 |           |
+----+--------+------+--------+--------+--------+------------+-----------+
6 rows in set (0.00 sec)
*/

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- ++++++++++++ Mysql 查询 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- 准备数据
-- 创建数据库
create database python_test charset=utf8;
	use python_test;
	select database();
	-- 创建数据表
	-- 创建 students 表
	create table students(
	    id int unsigned primary key auto_increment not null,
	    name varchar(20) default '',
	    age tinyint unsigned default 0,
	    height decimal(5,2),
	    gender enum('男','女','中性','保密') default '保密',
	    cls_id int unsigned default 0,
	    is_delete bit default 0
	);
	-- 创建 classes 表
	create table classes (
	    id int unsigned auto_increment primary key not null,
	    name varchar(30) not null
	);

	-- 插入数据
	-- 向students表中插入数据
	insert into students values
(0,'小明',18,180.00,2,1,0),
(0,'小月月',18,180.00,2,2,1),
(0,'彭于晏',29,185.00,1,1,0),
(0,'刘德华',59,175.00,1,2,1),
(0,'黄蓉',38,160.00,2,1,0),
(0,'凤姐',28,150.00,4,2,1),
(0,'王祖贤',18,172.00,2,1,1),
(0,'周杰伦',36,NULL,1,1,0),
(0,'程坤',27,181.00,1,2,0),
(0,'刘亦菲',25,166.00,2,2,0),
(0,'金星',33,162.00,3,3,1),
(0,'静香',12,180.00,2,4,0),
(0,'郭靖',12,170.00,1,4,0),
(0,'周杰',34,176.00,2,5,0);

	-- 向classes表中插入数据
	insert into classes values (0, "python_01期"), (0, "python_02期");

-- 查询
   -- 查询所有字段
   select * from students;
   select * from classes;
   -- 查询指定字段
   -- 利用 as 给字段起别名
   select name as '姓名', age as '年龄' from students;
   -- 利用 as 给表起别名
   select students.name, students.age from students;
   select s.name, s.age from students as s;
   -- 清除重复行
   select distinct gender from students;

-- 条件
   -- select ... from 表名 where ...;
   -- 比较运算符
   -- > 大于 < 小于 >= 大于等于 <= 小于等于 = 等于 != <> 不等于
   select * from students where age>18;

   -- 逻辑运算符
   -- and
   select * from students where age>18 and age<28;
   select * from students where age>18 and gender='女';
   -- or
   select * from students where age>18 or height>=180;
   -- not
   -- 查询不在 18岁以上的女性 这个范围的信息
   select * from students where not age>18 and gender=2;
   select * from students where not (age>18 and gender=2);
   -- 年龄不是小于或者等于18 并且是女性
   select * from students where not age<=18 and gender=2;
   select * from students where (not age<=18) and gender=2; -- 带括号可读性更高

   -- 模糊查询
   -- like
   -- % 替换一个或多个
   -- _ 替换一个
   -- 查询名字以'小'开头的
   select name from students where name like '小%';
   -- 查询名字包含'小'字的
   select name from students where name like '%小%';
   -- 查询名字是两个字的
   select name from students where name like '__';
   -- 查询名字是三个字及以上的
   select name from students where name like '___%';

   -- rlike 正则
   -- 以'周'开始的名字
   select name from students where name rlike '^周';
   -- 周开始 伦结尾
   select name from students where name rlike '^周.*伦$';

   -- 范围查询
   -- in (1, 3, 8) 表示非连续的范围内
   -- 查询年龄为 18, 34的姓名
   select name from students where age in (18, 34);
   -- 查询年龄不在 18, 34 范围的姓名
   select name from students where age not in (18, 34);
   -- between ... and ... 表示连续的范围
   select * from students where age not between 18 and 34;
   select * from students where not age between 18 and 34;
   -- 错误写法 select * from students where age not (between 18 and 34); -- between ... and ... 是一个整体

   -- 空判断 (要区分 null 和 '' 的区别)
   -- is null
   select * from students where height is null;
   -- is not null
   select * from students where height is not null;

-- 排序
   -- order by 字段
   -- asc 从小到大
   -- desc 从大到小
   select * from students where (age between 18 and 34) and gender=1;
   select * from students where (age between 18 and 34) and gender=1 order by age;
   select * from students where (age between 18 and 34) and gender=1 order by age desc;
   select * from students where (age between 18 and 34) and gender=2 order by height desc;
   -- order by 多个字段
   select * from students where (age between 18 and 34) and gender=2 order by height desc, id desc;
   select * from students where (age between 18 and 34) and gender=2 order by height desc, age asc, id desc;
   -- 按照年龄从小到大，身高从高到低
   select * from students order by age, height desc;

-- 聚合函数
   -- 总数 count()
   -- 查询男性有多少人
   select count(*) from students where gender=1;
   select count(*) as 男性人数 from students where gender=1;
   -- 最大值 max()
   -- 查询最大年龄
   select max(age) from students;
   select max(height) from students where gender=2;
   -- 最小值 min()
   -- 求和 sum()
   -- 平均值 avg()
   -- 计算平均年龄
   select avg(age) from students;
   select sum(age)/count(*) from students;
   -- 四舍五入 round(123.456, 1) 保留一位小数
   select round(avg(age),2) from students;
   -- 计算男性平均身高 保留2位小数
   select round(avg(height),2) from students where gender=1;
   -- select name, round(avg(height),2) from students where gender=1; 这种写法是错误的,要配合分组才会有结果

-- 分组 group by
   -- 按照性别分组，查询所有也性别
   select gender from students group by gender;
   select gender, count(*) from students group by gender;
   -- 计算男性平均身高 保留2位小数
   select gender, round(avg(height),2) from students group by gender;
   select gender, round(avg(height),2) from students where gender=1 group by gender;
   -- group_concat()
   -- 查询同种性别中的名字
   select gender, group_concat(name) from students where gender=1 group by gender;
   select gender, round(avg(height),2), group_concat(name) from students where gender=1 group by gender;
   -- having 对分组进行过滤
   -- 查询平均年龄超过30的性别，以及姓名 having avg(age)>30
   select gender, group_concat(name) from students group by gender having avg(age)>30;
   select gender, group_concat(name,' ', age), avg(age) from students group by gender having avg(age)>30;
   select gender, group_concat(name,' ', age), avg(age) from students group by gender having count(*)>2;

-- 分页
   -- limit start（从哪里开始）, count（总共显示几行）
   -- 限制查询结果显示记录条数    商品列表分页就是这么做的
   select * from students limit 2;
   select * from students limit 1, 5;
   -- 错误写法，分页是这么来，但sql语句不能这么写 select * from students limit 2*(6-1),2;
   -- 错误写法，limit只能在最后面 select * from students limit 10,2 order by age asc;
   select * from students order by age asc limit 10,2 ;

-- 连接查询
   -- inner join ... on  取交集(内连接)
   -- select * from 表名1 inner join 表名2;
   select * from students inner join classes;
   select * from students inner join classes on students.cls_id=classes.id;
   select students.*, classes.name from students inner join classes on students.cls_id=classes.id;
   select students.name, classes.name from students inner join classes on students.cls_id=classes.id;
   -- 利用 as 起别名
   select s.name, c.name from students as s inner join classes as c on s.cls_id=c.id;
   select s.name as 姓名, c.name as 班级 from students as s inner join classes as c on s.cls_id=c.id;
   -- order by 排序
   select s.name as 姓名, c.name as 班级 from students as s inner join classes as c on s.cls_id=c.id order by c.name;
   select s.name as 姓名, c.name as 班级 from students as s inner join classes as c on s.cls_id=c.id order by c.name, s.id;

   -- left join ... on 以左侧表为基准，左连接查询  (调换表的先后顺序就可以实现右连接查询，记一种就行)
   -- right join ... on 以右侧表为基准，右连接查询 

   -- 查询班级信息为空 (将前面的查询的结果为一个表去筛选，这种情况 where 和 having 都可以用)
   select students.*, classes.name from students left join classes on students.cls_id=classes.id where classes.id is null ;
   select students.*, classes.name from students left join classes on students.cls_id=classes.id having classes.name is null;

-- 自关联
   -- 一个表里的字段关联表里的另一个字段 （应用环境：公司上下级，城市关系）

   /*数据表结构：

	mysql> show create table province;
	+----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| Table    | Create Table                                                                                                                                                                                                  |
	+----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| province | CREATE TABLE `province` (
	  `id` int(5) NOT NULL AUTO_INCREMENT,
	  `name` varchar(255) DEFAULT '',
	  `pid` int(5) DEFAULT NULL,
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB AUTO_INCREMENT=3373 DEFAULT CHARSET=utf8 |
	+----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	1 row in set (0.00 sec)
	*/

   select * from province where name like "新疆%";
   select * from province where pid=112;
	/*
	mysql> select * from province where pid=112;
	+-----+-----------------------------------+------+
	| id  | name                              | pid  |
	+-----+-----------------------------------+------+
	| 522 | 乌鲁木齐市                        |  112 |
	| 523 | 克拉玛依市                        |  112 |
	| 524 | 吐鲁番地区                        |  112 |
	| 525 | 哈密地区                          |  112 |
	| 526 | 和田地区                          |  112 |
	| 527 | 阿克苏地区                        |  112 |
	| 528 | 喀什地区                          |  112 |
	| 529 | 克孜勒苏柯尔克孜自治州            |  112 |
	| 530 | 巴音郭楞州                        |  112 |
	| 531 | 昌吉州                            |  112 |
	| 532 | 博尔塔拉州                        |  112 |
	| 533 | 伊犁哈萨克自治州                  |  112 |
	| 534 | 塔城地区                          |  112 |
	| 535 | 阿勒泰州                          |  112 |
	| 536 | 省直辖行政单位                    |  112 |
	+-----+-----------------------------------+------+
	15 rows in set (0.00 sec)
	*/
	select * from province as sheng inner join province as shi on shi.pid=sheng.id having sheng.name="山东省"; 
	-- 思路：把一张表逻辑成两张表用 '内连接查询' 得出结果,再用 'having' 过滤。
	select * from province as sheng inner join province as shi on shi.pid=sheng.id having sheng.name="台湾省";

	select sheng.name as 省级行政区, shi.name as 地级市, shi.id as 地级市ID  from province as sheng inner join province as shi on shi.pid=sheng.id having sheng.name="湖北省";

-- 子查询 
   select * from students where height=(select max(height) from students);
   -- 这个和之前的效果是一样的，但 '子查询' 的效率比 '自关联查询' 略慢
   select * from province where pid=(select id from province where name="湖北省");



-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- ++++++++++++ 数据库的设计  +++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 三范式：
   -- 1NF 第一范式（1NF）：强调的是列的原子性，即列不能够再分成其他几列
   -- 2NF 第二范式（2NF）：首先是 1NF，另外包含两部分内容，一是表必须有一个主键；二是没有包含在主键中的列必须完全依赖于主键，而不能只依赖于主键的一部分
   -- 3NF 第三范式（3NF）：首先是 2NF，另外非主键列必须直接依赖于主键，不能存在传递依赖。即不能存在：非主键列 A 依赖于非主键列 B，非主键列 B 依赖于主键的情况


select goods.name ,t.cate_name, goods.price from goods inner join (select cate_name,max(price) as max from goods group by cate_name ) as t on goods.price=t.max and t.cate_name = goods.cate_name;


-- 拆表
-- 从其它表查询结果插入到新表中
insert into goods_cates (name) select cate_name from goods group by cate_name;
-- 同步数据(根据新表数据修改原表的数据)
update goods inner join goods_cates on goods.cate_name=goods_cates.name set goods.cate_name=goods_cates.id;
-- 修改表结构
alter table goods change cate_name cate_id int unsigned not null;
-- 外键
alter table goods add foreign key (cate_id) references goods_cates(id);


-- 根据已存在的表去新建表并插入数据
create table goods_brands(
	id int unsigned primary key auto_increment,
	name varchar(40) not null 
	) select brand_name as name from goods group by brand_name;
   -- 注意: 需要对brand_name 用as起别名，否则name字段就没有值
-- 同步数据(根据新表数据修改原表的数据)
update goods inner join goods_brands on goods.brand_name=goods_brands.name set goods.brand_name=goods_brands.id;
-- 修改表结构
alter table goods change brand_name brand_id int unsigned not null;
-- 添加外键
alter table goods add foreign key (brand_id) references goods_brands(id);

-- 修改多个字段属性
alter table goods
change cate_name cate_id int unsigned not null,
change brand_name brand_id int unsigned not null;

-- 取消外键
show create table goods; -- 查询外键名称
/*
| goods | CREATE TABLE `goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `cate_id` int(10) unsigned NOT NULL,
  `brand_id` int(10) unsigned NOT NULL,
  `price` decimal(10,3) NOT NULL DEFAULT '0.000',
  `is_show` bit(1) NOT NULL DEFAULT b'1',
  `is_saleoff` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `cate_id` (`cate_id`),
  KEY `brand_id` (`brand_id`),
  CONSTRAINT `goods_ibfk_1` FOREIGN KEY (`cate_id`) REFERENCES `goods_cates` (`id`),
  CONSTRAINT `goods_ibfk_2` FOREIGN KEY (`brand_id`) REFERENCES `goods_brands` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 |
*/
-- 取消单条外键
alter table goods drop foreign key goods_ibfk_1;
-- 取消多条外键
alter table goods drop foreign key goods_ibfk_1, drop foreign key goods_ibfk_2;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- 数据库30条军规 https://mp.weixin.qq.com/s/Yjh_fPgrjuhhOZyVtRQ-SA
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++