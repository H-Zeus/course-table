import 'package:course_table/utils.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'configs.dart';
import 'dart:io';

void main() async {
  var dir = (await getApplicationDocumentsDirectory()).path + dbName;
  File file = File(dir);
  if(!(await file.exists())) {
    await file.create();
  }
  return runApp(new CourseTable());
}

class CourseTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'course table',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  void _onAddButtonPressed(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new CourseAddPage();
    }));
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Course Table"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.add),
            onPressed: () {
              _onAddButtonPressed(context);
            },
          ),
        ],
      ),
      body: new Center(child: new Text("hello")),
    );
  }
}

class CourseAddPage extends StatefulWidget {
  CourseAddPage({Key key}) : super(key: key);

  @override
  _CourseAddPage createState() => new _CourseAddPage();
}

class _CourseAddPage extends State<CourseAddPage> {
  final TextEditingController _controller = new TextEditingController();

  void _onButtonPressed() {
    saveCourseTable(_controller.text);
  }

  void _testDB() async {
    var db = await getTableData();
    print(db["1"]["1"]["1"]["room"]);
  }

  Widget _inputAndButton() {
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
              child: Text('Gradient Button', style: TextStyle(fontSize: 20)),
            ),
            color: Theme.of(context).accentColor,
          ),
          new RaisedButton(
            onPressed: _testDB,
            child: new Container(
              child: Text('Test Db', style: TextStyle(fontSize: 20)),
            ),
            color: Theme.of(context).accentColor,
          )
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
        body: _inputAndButton(),
      ),
    );
  }
}
