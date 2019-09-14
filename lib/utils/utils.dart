import 'dart:convert';

import 'package:course_table/configs.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

///解析课程信息的字符串
Map<String, dynamic> parse_course(String s) {
  var name = s.split("(讲课学时)")[0];
  var tmp = s.split("(讲课学时)")[1];
  var teacher = "";

  for(int i = 0; i < tmp.length; i++) {
    if("1234567890".contains(tmp[i])) break;
    teacher += tmp[i];
  }

  tmp = s.split(teacher)[1];
  var sweek = tmp.split("(周)")[0];
  var week = [];
  if(sweek.contains("-")) {
    int begin = int.parse(sweek.split("-")[0]);
    int end = int.parse(sweek.split("-")[1]);
    for(int i = begin; i <= end; i++) {
      week.add(i.toString());
    }
  } else {
    week.add(sweek);
  }

  var room = tmp.split("(周)")[1];

  return {
    "name": name,
    "teacher": teacher,
    "sweek": sweek,
    "week": week,
    "room": room
  };
}

/// 从html中分离出课表字符串
/// [content] 为html字符串
List<dynamic> parse_course_table(String content) {
  var list = <dynamic>[];
  Document document = parse(content);
  var table = document.body.querySelector('#kbtable');
  var tbody = table.querySelector('tbody');
  var trs = tbody.children;
  for(int tr_ind = 1; tr_ind <= 5; tr_ind++) {
    var tds = trs[tr_ind].children;
    for(int td_ind = 1; td_ind <= 7; td_ind++) {
      var course_text = tds[td_ind].querySelector('div .kbcontent').text;
      if(course_text.length < 5) continue;
      var course = course_text.split("---------------------");
      for(int len = 0; len < course.length; len++) {
        var course_info = parse_course(course[len]);
        course_info["row"] = tr_ind.toString();
        course_info["col"] = td_ind.toString();
        list.add(course_info);
      }
    }
  }
  return list;
}

Map<String, dynamic> course_to_map(List<dynamic> list) {
  var course_db = <String, dynamic>{};
  for(int len = 0; len < list.length; len++) {
    var course = list[len];
    var row = course["row"];
    var col = course["col"];
    for(var week in course["week"]) {
      if(!course_db.containsKey(week)) {
        course_db[week] = <String, dynamic>{};
      }
      if(!course_db[week].containsKey(row)) {
        course_db[week][row] = <String, dynamic>{};
      }
      course_db[week][row][col] = <String, dynamic>{
        "name": course["name"],
        "teacher": course["teacher"],
        "sweek": course["sweek"],
        "room": course["room"]
      };
    }
  }
  return course_db;
}

void saveCourseTable(String content) async {
  try {
    final dbPath = (await getApplicationDocumentsDirectory()).path + dbName;
    print(dbPath);
    var list = parse_course_table(content);
    var course = course_to_map(list);
    final JSON = JsonCodec();
    File file = File(dbPath);
    await file.writeAsString(JSON.encode(course));
    print(JSON.encode(course));
    print("success");
  } catch(e) {
    print("error");
  }
}

Future<Map<String, dynamic>> getTableData() async {
    final dbPath = (await getApplicationDocumentsDirectory()).path + dbName;
    File file = File(dbPath);
    if(!(await file.exists())) return null;
    try {
      var json = await file.readAsString();
      final JSON = JsonCodec();
      return JSON.decode(json);
    } catch(e) {
      return null;
    }
}
