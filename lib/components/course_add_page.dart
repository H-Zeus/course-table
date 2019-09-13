import 'package:course_table/utils/provider.dart';
import 'package:flutter/material.dart';
import 'package:course_table/utils/utils.dart';

//class CourseAddPage extends StatefulWidget {
//  CourseAddPage({Key key}) : super(key: key);
//
//  @override
//  _CourseAddPage createState() => new _CourseAddPage();
//}

class CourseAddPage extends StatelessWidget {
  final TextEditingController _controller = new TextEditingController();

  void _onButtonPressed() async {
    await saveCourseTable(_controller.text);
    await Provider.update(this);
  }

  Widget _inputAndButton(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new TextField(
            controller: _controller,
            decoration: new InputDecoration(
              hintText: '请输入课表的html代码',
              hintStyle: new TextStyle(color: Colors.grey),
            ),
          ),
          new RaisedButton(
            onPressed: _onButtonPressed,
            child: new Container(
              child: Text('导入课表', style: TextStyle(fontSize: 20)),
            ),
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("导入课表"),
        ),
        body: _inputAndButton(context),
      ),
    );
  }
}