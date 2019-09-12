import 'package:flutter/material.dart';

main() {
  return runApp(new CourseTable());
}

class CourseTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'course table',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {

  void _onAddButtonPressed(BuildContext context) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new CourseAddPage();
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Course Table"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.add),
            onPressed: () { _onAddButtonPressed(context); },
          ),
        ],
      ),
      body: new Center(child: new Text("hello")),
    );
  }
}


class CourseAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("导入课表"),
        ),
        body: new Text("hello"),
      ),
    );
  }
}