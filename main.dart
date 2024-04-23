// ignore_for_file: deprecated_member_use


import 'package:flutter/material.dart';
import 'package:my_flutter_project/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  // init hive
  await Hive.initFlutter();

  // open box
  var box =  await Hive.openBox("thebox");
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

