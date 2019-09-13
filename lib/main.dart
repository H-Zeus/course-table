import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:course_table/components/main_pages.dart';
import 'configs.dart';
import 'package:course_table/utils/provider.dart';
import 'dart:io';
import 'package:course_table/utils/week.dart';

void main() async {
  final dir = (await getApplicationDocumentsDirectory()).path + dbName;
  File file = File(dir);
  if(!(await file.exists())) {
    await file.create();
  }
  // TODO: init Week
  Week.week = Week.week = 1;
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
      ),
      home: new MainPage(),
      debugShowMaterialGrid: false,
    );
  }
}




