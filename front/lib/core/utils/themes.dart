import 'package:flutter/material.dart';

class MyTheme{
  static  final primaryColor = Colors.blue.shade300;

  static final darkTheme = ThemeData(
    primaryColor: primaryColor,
    dividerColor: Colors.white,
  );
  static final lightTheme = ThemeData(
    primaryColor: primaryColor,
    dividerColor: Colors.black,
  );
}