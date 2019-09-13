import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:course_table/configs.dart';

class Week {
  static int week;
  static int curWeek;

  static void init() async {
    final path = (await getApplicationDocumentsDirectory()).path + dateIndex;
    File file = File(path);
    String SWeek = await file.readAsString();
    // TODO:
  }

  static void update(int newWeek) {
    week = newWeek;
  }
}