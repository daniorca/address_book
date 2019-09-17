import 'package:flutter/material.dart';

final ThemeData kTheme = _buildTheme();

ThemeData _buildTheme() {
  return ThemeData(
    primaryColor: Colors.purple[700],
    accentColor: Colors.black,
    canvasColor: Colors.white,
    primaryIconTheme: IconThemeData(color: Colors.white),
    backgroundColor: Colors.white,
    textTheme: TextTheme(
      display1: TextStyle(
        fontFamily: 'GTE',
        color: Colors.black,
        fontSize: 14,
      ),
      display2: TextStyle(
        fontFamily: 'GTE',
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontSize: 15,
      ),
      display3: TextStyle(
        fontFamily: 'GTE',
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
