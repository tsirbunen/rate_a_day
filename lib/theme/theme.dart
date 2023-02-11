import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  fontFamily: 'Quicksand',
  textTheme: const TextTheme(
    // Primary info text
    headline5: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
    // Secondary info text
    bodyText1: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),

    // Date or day minor
    headline2: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600), //, fontStyle: FontStyle.italic),
    // Date or day major
    headline1: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),

    headline3: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
    headline4: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic),
    headline6: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(
    // Main pages background
    background: Colors.black,

    // AppBar and Navigation Menu buttons
    secondaryContainer: Colors.grey[700],
    onSecondaryContainer: Colors.black,

    // Evaluation icons
    tertiaryContainer: Colors.grey[800],

    // Text
    primary: Colors.grey[400],
    secondary: Colors.grey[600],

    brightness: Brightness.dark,
    primaryContainer: Colors.grey[600],
    onPrimaryContainer: Colors.grey[200],

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
        primary: Colors.grey[700],
        shape: const StadiumBorder(),
        textStyle: const TextStyle(fontWeight: FontWeight.w600)),
  ),
);
