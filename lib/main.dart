import 'package:firbase_todo/pages/Add.dart';
import 'package:firbase_todo/pages/Home.dart';
import 'package:firbase_todo/pages/Login.dart';
import 'package:firbase_todo/pages/Register.dart';
import 'package:flutter/material.dart';

import 'Theme/Theme.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  var routes = <String, WidgetBuilder>{
    "/Login": (BuildContext context) => new Login(),
    "/Register": (BuildContext context) => new Register(),
    "/Home": (BuildContext context) => new Home(),
    "/Add": (BuildContext context) => new Add(),
  };

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.ui,
      home: new Login(),
      routes: routes,
    );
  }
}
