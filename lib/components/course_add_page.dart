import 'package:course_table/utils/provider.dart';
import 'package:flutter/material.dart';


class CourseAddPage extends StatefulWidget {
  @override
  _CourseAddPage createState() => _CourseAddPage();
}

class _CourseAddPage extends State<CourseAddPage> {

  String text = "";

  void _onButtonPressed(BuildContext context) async {
    bool result = false;
    if(this.text != null && this.text != "") {
      result = await Provider.update(this.text);
    }
    final successInfo = SnackBar(
      content:  Text('添加成功'),
      backgroundColor: Theme.of(context).primaryColor,
      duration:Duration(seconds: 5),// 持续时间
    );
    final failureInfo = SnackBar(
      content: Text("添加失败"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 5),
    );
    if(result) {
      Scaffold.of(context).showSnackBar(successInfo);
    } else {
      Scaffold.of(context).showSnackBar(failureInfo);
    }
  }

  Widget _inputAndButton(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextField(
//              controller: _controller, /// 这里不适用controller的原因是当收起键盘时，输入的东西会被清空
              decoration: new InputDecoration(
                hintText: '请输入强制课表所在页的html代码',
                hintStyle: new TextStyle(color: Colors.grey),
              ),
              onChanged: (String text){
                setState(() {
                  this.text = text;
                });
              },
              autofocus: false,
            ),
            margin: EdgeInsets.all(10.0),
          ),
          new RaisedButton(
            onPressed: () {
              _onButtonPressed(context);
            },
            child: new Container(
              child: Text('导入课表', style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("congjian");
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("导入课表"),
        ),
        body: new Builder(builder: (BuildContext context){
          return _inputAndButton(context);
        }),
    );
  }
}