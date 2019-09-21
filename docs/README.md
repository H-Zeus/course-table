通过对智校园app抓包，获取到的接口如下：

- `http://app.qzdatasoft.com:9876/qzkjapp//phone/provinceData` 智校园启动时会获取各所学校的相关信息,其中包括学校的id，学校服务器地址
- `http://app.qzdatasoft.com:9876/qzkjapp/phone/{学校id}/{学号}` 智校园获取的接口列表，其中包含参数说明
- `http://jwgl.sdust.edu.cn/app.do?method=authUser&xh={学号}&pwd={密码}` 登录操作，返回token，以后需要登录的操作中都需在请求头中指明token，无需指明cookie
- `http://jwgl.sdust.edu.cn/app.do?method=getKbcxAzc&xh={学号}&xnxqid={学年}&zc={周次}` 课表查询api

其他接口可通过上面的url进行获取