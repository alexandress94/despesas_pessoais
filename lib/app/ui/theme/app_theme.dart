import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  brightness: Brightness.dark,
  // accentColor: Color(0xff2C3E50),
  accentColor: Colors.purple,
  primarySwatch: Colors.purple,
  primaryColor: Color(0xff000000),
  textTheme: TextTheme(
    // ignore: deprecated_member_use
    body1: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    // ignore: deprecated_member_use
    title: TextStyle(
      color: Colors.white,
    ),
    button: TextStyle(
      color: Colors.transparent,
    )

  )
);

TextStyle textDefult  = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold
);