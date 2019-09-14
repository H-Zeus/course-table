import 'package:flutter/material.dart';
import 'package:course_table/components/course_add_page.dart';
import 'package:course_table/components/slide_table.dart';
import 'package:course_table/components/setting_bar.dart';
import 'package:course_table/utils/week_index.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _MainPageState();
}

class _MainPageState extends State with SingleTickerProviderStateMixin {

  var _week = WeekIndex.curWeek;
  var _curWeek = WeekIndex.curWeek;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  void _handleWeekBack() {
    setState(() {
      _week = _curWeek;
    });
  }

  void _handleCurWeekChange(int week) async {
    await WeekIndex.update(week);
    setState(() {
      _week = week;
      _curWeek = week;
    });
    print("cur week change $week");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Row(
          children: <Widget>[
            new Text("第"),
            new SizedBox(
              width: 30.0,
              child: new Center(
                child: new Text(_week.toString()),
              ),
            ),
            new Text("周"),
          ],
        ),
        leading: IconButton(
          icon: new Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();  /// 显示左侧选项栏

          },
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

      drawer: new Drawer(
        child: new SettingBar(onWeekChange: _handleCurWeekChange, curWeek: _curWeek,),
      ),

      floatingActionButton: new FloatingActionButton(
        onPressed: _handleWeekBack,
        child: new Icon(Icons.arrow_back),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
