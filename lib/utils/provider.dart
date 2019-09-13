import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:course_table/configs.dart';
import 'dart:convert';

/// 在flutter中无法在widget的initState中异步读取数据库，所以换成一个全局对象来保存
/// 该类维护数据库的状态，每一次修改数据库，必须调用update方法写入数据库
/// 为了防止多个地方更新db引起混乱，强烈建议使用update方法对db进行更新
/// update中obj为所调用的对象名，例如：
///   对函数：Provider.update(function name)
///   对对象: Provider.update(this)
class Provider {
  static Map<String, dynamic> db;

  static void init() async {
    final dbPath = (await getApplicationDocumentsDirectory()).path + dbName;
    File file = File(dbPath);
    if(!(await file.exists())) return null;
    try {
      var json = await file.readAsString();
      final JSON = JsonCodec();
      db = JSON.decode(json);
    } catch(e) {
      db = null;
    }
  }

  static void update(dynamic obj) async {
    print(obj.toString() + " update");
    init();
  }
}
