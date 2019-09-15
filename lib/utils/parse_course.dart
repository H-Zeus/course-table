import 'package:course_table/configs.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:path_provider/path_provider.dart';

class ParseCourse {

  /// 解析每门课的详细信息
  static Map<String, dynamic> _parseCourse(String info) {
    var name = info.split("(讲课学时)")[0];
    var tmp = info.split("(讲课学时)")[1];
    var teacher = "";

    for(int i = 0; i < tmp.length; i++) {
      if("1234567890".contains(tmp[i])) break;
      teacher += tmp[i];
    }

    tmp = info.split(teacher)[1];
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
  static List<dynamic> _parseCourseTable(String content) {
    var list = <dynamic>[];
    Document document = parse(content);
    var table = document.body.querySelector('#kbtable');
    var tbody = table.querySelector('tbody');
    var trs = tbody.children;
    for(int trInd = 1; trInd <= 5; trInd++) {
      var tds = trs[trInd].children;
      for(int tdInd = 1; tdInd <= 7; tdInd++) {
        var courseText = tds[tdInd].querySelector('div .kbcontent').text;
        if(courseText.length < 5) continue;
        var course = courseText.split("---------------------");
        for(int len = 0; len < course.length; len++) {
          var courseInfo = _parseCourse(course[len]);
          courseInfo["row"] = trInd.toString();
          courseInfo["col"] = tdInd.toString();
          list.add(courseInfo);
        }
      }
    }
    return list;
  }

  /// 使用每门课的详细信息构建map
  static Map<String, dynamic> _courseToMap(List<dynamic> list) {
    var courseDb = <String, dynamic>{};
    for(int len = 0; len < list.length; len++) {
      var course = list[len];
      var row = course["row"];
      var col = course["col"];
      for(var week in course["week"]) {
        if(!courseDb.containsKey(week)) {
          courseDb[week] = <String, dynamic>{};
        }
        if(!courseDb[week].containsKey(row)) {
          courseDb[week][row] = <String, dynamic>{};
        }
        courseDb[week][row][col] = <String, dynamic>{
          "name": course["name"],
          "teacher": course["teacher"],
          "sweek": course["sweek"],
          "room": course["room"]
        };
      }
    }
    return courseDb;
  }

  /// 解析课表
  /// [content] 为强智课表所在也的html源码字符串
  static Future<Map<String, dynamic>> parseTable(String content) async {
    try {
      final dbPath = (await getApplicationDocumentsDirectory()).path + dbName;
      print(dbPath);
      var list = _parseCourseTable(content);
      var course = _courseToMap(list);
      return course;
    } catch(e) {
      return null;
    }
  }
}

//Future<Map<String, dynamic>> getTableData() async {
//    final dbPath = (await getApplicationDocumentsDirectory()).path + dbName;
//    File file = File(dbPath);
//    if(!(await file.exists())) return null;
//    try {
//      var json = await file.readAsString();
//      final JSON = JsonCodec();
//      return JSON.decode(json);
//    } catch(e) {
//      return null;
//    }
//}
