import 'package:flutter/material.dart';
import 'package:course_table/utils/provider.dart';

class CourseTable extends StatelessWidget {
  CourseTable({
    Key key,
    @required this.week
  }):super(key: key);

  final int week;

  /// 表头宽度  表头高度  格子宽度  格子高度
  double titleWidth;
  double titleHeight;
  double gridWidth;
  double gridHeight;

  Map<String, dynamic> db;

  BoxDecoration titleDecoration;
  BoxDecoration outerGridDecoration;
  BoxDecoration innerGridDecoration;

  void _initSize(BuildContext context) {
    print("CourseTable._initSize");
    this.titleWidth = 20.0;
    this.titleHeight = 30.0;
    this.gridWidth = (MediaQuery.of(context).size.width - titleWidth) / 7;
    this.gridHeight = 120.0;

    this.db = Provider.db;

    this.titleDecoration = BoxDecoration(
      color: Colors.grey[100],
    );
    this.outerGridDecoration = BoxDecoration(
      color: Colors.white,
    );
    this.innerGridDecoration = BoxDecoration(
      color: Theme.of(context).accentColor,
      borderRadius: new BorderRadius.all(
        const Radius.circular(8.0),
      ),
      boxShadow: <BoxShadow> [
        new BoxShadow(
          color: Colors.grey[300],
          offset: new Offset(1.0, 1.0),
          blurRadius: 4.0,
        ),
      ],
    );
  }

  Widget _renderGrid(BuildContext context, int row, int col) {
    var data;
    try {
      data = db[week.toString()][row.toString()][col.toString()];
    } catch(e) {
      data = null;
    }

    final innerWidget =
    data == null ? new Container(
      child: null,
    ) : new Container(
      child: new Text(
        data["name"]+"@"+data["room"],
        style: new TextStyle(
          fontSize: 12.0,
          color: Colors.white,
        ),
      ),
      decoration: innerGridDecoration,
      margin: EdgeInsets.all(3.0),
      padding: EdgeInsets.all(2.0),
    );

    return new Container(
      child: innerWidget,
      width: gridWidth,
      height: gridHeight,
      decoration: outerGridDecoration,
    );
  }

  Widget _renderTitle(BuildContext context) {
    final weekName = const ["周一", "周二", "周三", "周四", "周五", "周六", "周日"];
    final list = <Widget>[];

    list.add(new Container(
      child: null,
      decoration: titleDecoration,
      width: titleWidth,
      height: titleHeight,
    ));

    for(int i = 1; i <= 7; i++) {
      list.add(new Container(
        alignment: Alignment.center,
        decoration: titleDecoration,
        child: new Text(weekName[i-1]),
        width: gridWidth,
        height: titleHeight,
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: list,
    );
  }

  Widget _renderRow(BuildContext context, int row) {
    final list = <Widget>[];

    list.add(new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Text((row * 2 - 1).toString()),
          new Text((row * 2).toString()),
        ],
      ),
      decoration: titleDecoration,
      width: titleWidth,
      height: gridHeight,
    ));

    for(int col = 1; col <= 7; col++) {
      list.add(_renderGrid(context, row, col));
    }

    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: list,
    );
  }

  @override
  Widget build(BuildContext context) {
    _initSize(context);  /// 该函数必须首先调用进行宽度高度及数据库的初始化

    final rows = <Widget>[];
    rows.add(_renderTitle(context));
    for(int row = 1; row <= 5; row++) {
      rows.add(_renderRow(context, row));
    }

    return Column(
      children: rows,
    );
  }
}