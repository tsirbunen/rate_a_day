import 'package:flutter/material.dart';

const Color veryPaleGrey =
    Color.fromARGB(255, 245, 245, 245); // Colors.grey[100]
const Color paleGrey = Color.fromARGB(255, 224, 224, 224); // Colors.grey[300]
const Color didLearnBlue = Color.fromARGB(255, 33, 150, 243); //Colors.blue[500]
const Color veryDarkGrey = Color.fromARGB(255, 66, 66, 66); // Colors.grey[800],
const Color mediumGrey = Color.fromARGB(255, 158, 158, 158); //Colors.grey[500],
const Color mediumPlusGrey =
    Color.fromARGB(255, 117, 117, 117); //Colors.grey[600],

ThemeData themeData = ThemeData(
  fontFamily: 'Quicksand',
  textTheme: const TextTheme(
    // App title in AppBar
    bodyText2: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    // Page title
    headline3: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w800,
      color: veryPaleGrey,
    ),
    // General info: Page subtitle, info content and radio selector info
    bodyText1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: paleGrey,
    ),
    // Calendar day number did learn (= blue)
    subtitle1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: didLearnBlue,
    ),
    // Calendar day number did not learn (= grey)
    subtitle2: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: veryDarkGrey,
    ),
    // Cumulated (happy, unhappy or did learn evaluations)
    headlineLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    // Menu buttons
    headline6: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: mediumGrey,
    ),
    // Calendar day label
    labelMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: mediumPlusGrey,
    ),
    // Date or day major
    headline1: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: veryPaleGrey,
    ),
    // Info paragraph title, save evaluation button, info content title
    headline4: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: veryPaleGrey,
    ),
    // Radio selector label
    headline2: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
    ),
    // Rate a day day button minor text
    headline5: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: paleGrey,
    ),
    button: TextStyle(fontSize: 22.0),
  ),
  unselectedWidgetColor: Colors.grey[700],
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(
    // AppBar container and Navigation Menu buttons
    // secondaryContainer: Colors.grey[700],
    secondaryContainer: Colors.grey[500],

    brightness: Brightness.dark,
    // Main pages background
    background: Colors.grey[900],
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
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
    ),
  ),
);
