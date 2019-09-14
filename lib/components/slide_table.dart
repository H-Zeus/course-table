import 'package:flutter/material.dart';
import 'package:course_table/components/course_table.dart';

/// [onWeekChange] 为当前周改变时的回调函数，影响顶部导航栏显示
/// [offset] 为显示的周数
class SlideTable extends StatefulWidget {
  SlideTable({Key key, @required this.onWeekChange, this.offset = 1})
      : super(key: key);

  final ValueChanged<int> onWeekChange;
  final int offset;

  @override
  _SlideTableState createState() => _SlideTableState();
}

class _SlideTableState extends State<SlideTable> {
  void _handlePageChange(int i) {
    widget.onWeekChange(i + 1);
  }

  @override
  Widget build(BuildContext context) {
    final offset = widget.offset;
    print("SlideTable rebuild  $offset");
    final list = <Widget>[];
    for (int i = 1; i <= 20; i++) {
      list.add(CourseTable(
        week: i,
      ));
    }

    return Container(
      child: new PageView(
        /// 这里需要加key，否者flutter无法监测到状态的改变
        key: new Key(offset.toString()),
        children: list,
        controller: new PageController(
          initialPage: offset - 1,
        ),
        onPageChanged: _handlePageChange,
      ),
    );
  }
}
