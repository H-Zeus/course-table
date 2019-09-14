import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingBar extends StatefulWidget {
  SettingBar({Key key, @required this.onWeekChange, this.curWeek = 1 }) : super(key : key);

  final ValueChanged<int> onWeekChange;
  final int curWeek;

  @override
  _SettingBarState createState() => _SettingBarState();
}

class _SettingBarState extends State<SettingBar> {

  int _curWeek;

  @override
  void initState() {
    _curWeek = widget.curWeek;
  }

  @override
  Widget build(BuildContext context) {

    final textStyle = TextStyle(
      fontSize: 16.0,
    );

    final weekList = <int>[];
    for(int i = 1; i <= 20; i++) {
      weekList.add(i);
    }

    return new Column(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: null,
          height: 100.0,
        ),
        const SizedBox(
          height: 16.0,
        ),
        new Container(
          child: new ListTile(
            title: new Row(
              children: <Widget>[
                new Icon(Icons.calendar_today),
                new SizedBox(width: 10.0,),
                new Text('当前周数:', style: textStyle,)
              ],
            ),
            trailing: DropdownButton<int>(
              value: _curWeek,
              onChanged: (int newValue) {
                setState(() {
                  _curWeek = newValue;
                });
                widget.onWeekChange(newValue);
              },
              items: weekList.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
