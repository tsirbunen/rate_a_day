import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  fontFamily: 'Quicksand',
  textTheme: const TextTheme(
    // Primary info text
    headline5: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
    // Secondary info text
    bodyText1: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
    // Date or day minor
    headline2: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
    // Date or day major
    headline1: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
    // Custom App Bar
    headline3: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
    headline4: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic),
    // Calendar day number and cumulated count
    headline6: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    button: TextStyle(fontSize: 22.0),
  ),
  unselectedWidgetColor: Colors.grey[700],
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(
    brightness: Brightness.dark,
    // Main pages background
    background: Colors.grey[900],
    // AppBar and Navigation Menu buttons
    // secondaryContainer: Colors.grey[700],
    secondaryContainer: Colors.grey[500],
    onSecondaryContainer: Colors.black,
    // Evaluation icons
    tertiaryContainer: Colors.grey[800],
    // Text
    primary: Colors.grey[100],
    secondary: Colors.grey[300],
    // Calendar border and numbers and text
    primaryContainer: Colors.grey[600],
    // Evaluation icons
    tertiary: Colors.lightGreen[700],
    onTertiary: Colors.blue[500],
    error: Colors.amber[900],
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        primary: Colors.grey[700],
        shape: const StadiumBorder(),
        textStyle: const TextStyle(fontWeight: FontWeight.w600)),
  ),
);
