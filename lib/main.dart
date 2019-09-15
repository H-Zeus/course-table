import 'package:course_table/utils/week_index.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:course_table/components/main_pages.dart';
import 'configs.dart';
import 'package:course_table/utils/provider.dart';
import 'dart:io';

void main() async {
  final dir = (await getApplicationDocumentsDirectory()).path;
  File dbFile = File(dir + dbName);
  if(!(await dbFile.exists())) {
    await dbFile.create();
  }

  await WeekIndex.init();
  await Provider.init();
  return runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'course table',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
//        primaryColor: Colors.blue,
      ),
      home: new MainPage(),
      debugShowMaterialGrid: false,
    );
  }
}
