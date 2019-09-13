import 'package:flutter/material.dart';
import 'package:course_table/components/course_add_page.dart';
import 'package:course_table/components/slide_table.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _week = 1;

  void _onAddButtonPressed(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new CourseAddPage();
    }));
  }

  void _handleWeekChange(int week) {
    setState(() {
      _week = week;
    });
    print("week change");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Row(
          children: <Widget>[
            new Text("第"),
            new SizedBox(
              width: 30.0,
              child: new Center(
                child: new Text("$_week"),
              ),
            ),
            new Text("周"),
          ],
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.add),
            onPressed: () {
              _onAddButtonPressed(context);
            },
          ),
        ],
      ),
      body: new SlideTable(onWeekChange: _handleWeekChange, offset: _week,),
    );
  }
}
