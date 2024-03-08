import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData ui =  ThemeData(
    primarySwatch: Colors.purple,
    hintColor: Colors.blueGrey,
  );
  static LinearGradient gradient = const LinearGradient(
    stops: [0.0, 1.0],
    tileMode: TileMode.clamp,
    begin: Alignment(0.0, -1.0),
    end: Alignment(0.0, 0.6),
    colors: <Color>[
      Color(0xFF3366FF),
      Color(0xFF00CCFF),
    ],
  );
}
