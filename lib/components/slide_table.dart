import 'package:flutter/material.dart';
import 'package:course_table/components/course_table.dart';

/// [onWeekChange] 为当前周改变时的回调函数，影响顶部导航栏显示
/// [offset] 为显示的周数
class SlideTable extends StatelessWidget {

  SlideTable({Key key, this.onWeekChange, this.offset = 1}) :
        this.pageController = PageController(initialPage: offset-1),
        super(key : key);

  final int offset;
  final ValueChanged<int> onWeekChange;
  final PageController pageController;

  void _handlePageChange(int index) async {
    /// 等待到达指定页面时才进行onWeekChange的回调，否者会造成页面的跳动
    /// 指定页面为index，时间为duration，动画为curve
    await pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
    onWeekChange(index + 1);
  }

  @override
  Widget build(BuildContext context) {
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
        controller: pageController,
        onPageChanged: _handlePageChange,
      ),
    );
  }
}
