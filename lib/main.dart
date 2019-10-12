import 'package:flutter/material.dart';
import 'homepage.dart';
import 'loginpage.dart';
import 'signuppage.dart';

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
      },
    );
  }
}
