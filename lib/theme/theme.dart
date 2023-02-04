import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  fontFamily: 'Quicksand',
  textTheme: const TextTheme(
    headline3: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
    headline4: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic),
    headline2: TextStyle(
        fontSize: 24, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic),
    headline5: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
    headline1: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(
    // background: Colors.pink,
    brightness: Brightness.dark,
    primary: Colors.grey[700],
    primaryContainer: Colors.grey[600],
    onPrimaryContainer: Colors.grey[200],
    secondary: Colors.grey[300],
    // secondaryContainer: Colors.grey[500],

    // secondary: Colors.orange,
    // tertiary: Colors.green,
    tertiary: Colors.lightGreen[700],
    // onTertiary: Colors.blue[700],
    onTertiary: Colors.blue[500],
    // error: Colors.red[900],
    error: Colors.amber[900],
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        textStyle: const TextStyle(fontWeight: FontWeight.w600)),
  ),
);
