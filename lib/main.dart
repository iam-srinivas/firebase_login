import 'package:flutter/material.dart';
import 'package:folk/folklist.dart';
import 'package:folk/homepage.dart';
import 'package:folk/loginpage.dart';
import 'package:folk/signuppage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Folk',
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        "/LoginPage": (BuildContext context) => LoginPage(),
        "/SignupPage": (BuildContext context) => SignupPage(),
        "/FolkList": (BuildContext context) => FolkList(),
      },
    );
  }
}
