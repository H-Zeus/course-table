import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:course_table/configs.dart';
import 'dart:convert';
import 'package:course_table/utils/parse_course.dart';

/// 在flutter中无法在widget的initState中异步读取数据库，所以换成一个全局对象来保存
/// 程序开始之前，需调用[init]方法对该类进行初始化
/// 该类维护数据库的状态，使用[update]方法对数据库进行修改
class Provider {
  static Map<String, dynamic> db;

  /// 初始化[db]
  static void init() async {
    File file = await _getFile();
    try {
      var json = await file.readAsString();
      final JSON = JsonCodec();
      db = JSON.decode(json);
    } catch(e) {
      db = null;
    }
  }

  /// 更新数据库，包括数据库文件
  /// [content] 为强制教务系统课表所在页的html源码字符串
  static Future<bool> update(String content) async {
    final JSON = JsonCodec();
    try {
      final data = await ParseCourse.parseTable(content);
      assert(data != null);
      File file = await _getFile();
      final json = JSON.encode(data);
      await file.writeAsString(json);
      await init();
    } catch(e) {
      print(e);
      return false;
    }
    return true;
  }

  static Future<File> _getFile() async {
    final dbPath = (await getApplicationDocumentsDirectory()).path + dbName;
    File file = File(dbPath);
    if(!(await file.exists())) {
      await file.create();
    }
    return file;
  }
}
