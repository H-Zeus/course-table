import 'package:flutter/material.dart';
import 'package:course_table/components/course_table.dart';

/// [onWeekChange] 为当前周改变时的回调函数，影响顶部导航栏显示
/// [offset] 为显示的周数
class SlideTable extends StatelessWidget {
  SlideTable({Key key, @required this.onWeekChange, this.offset = 1})
      : super(key: key);

  final ValueChanged<int> onWeekChange;
  final int offset;

  void _handlePageChange(int i) {
    onWeekChange(i + 1);
    print(i);
  }

  @override
  Widget build(BuildContext context) {
    final list = <Widget>[];
    for (int i = 1; i <= 20; i++) {
      list.add(CourseTable(week: i,));
    }

    return Container(
      child: new PageView(
        children: list,
        controller: new PageController(
          initialPage: offset-1,
        ),
        onPageChanged: _handlePageChange,
      ),
    );
  }
}
