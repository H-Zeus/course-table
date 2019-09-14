import 'package:path_provider/path_provider.dart';
import 'package:course_table/configs.dart';
import 'dart:io';

/// 该类维护当前时第几周
class WeekIndex {
  static int curWeek;

  static void init() async {
    final dir = (await getApplicationDocumentsDirectory()).path + weekIndex;
    File file = File(dir);
    if (!(await file.exists())) {
      await file.create();
      await _setWeekIndex(1);
    }
    curWeek = await _getWeekIndex();
  }

  static void update(int week) async {
    await _setWeekIndex(week);
    curWeek = await _getWeekIndex();
  }

  /// 设置周数的锚点，锚点为第一周的周一零点
  static void _setWeekIndex(int week) async {
    assert(week >= 1);
    week -= 1;
    var date = DateTime.now();
    date = date.subtract(Duration(days: week * 7));

    // 获取每周一的零点，误差在一秒内
    date = date.subtract(Duration(
      days: date.weekday - 1,
      hours: date.hour,
      minutes: date.minute,
      seconds: date.second,
    ));

    final dir = (await getApplicationDocumentsDirectory()).path + weekIndex;
    File file = File(dir);
    try {
      await file.writeAsString(date.toString());
    } catch (e) {
      print(e);
    }
  }

  /// 获取当前时第几周
  static Future<int> _getWeekIndex() async {
    final dir = (await getApplicationDocumentsDirectory()).path + weekIndex;
    File file = File(dir);
    try {
      String timeString = await file.readAsString();
      var date = DateTime.parse(timeString);
      var now = DateTime.now();
      var diff = now.difference(date);
      return diff.inDays ~/ 7 + 1;
    } catch (e) {
      print(e);
      return 1;
    }
  }
}
