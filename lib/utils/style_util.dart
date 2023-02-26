import 'package:flutter/material.dart';

class StyleUtil {
  static TextStyle appTitle(final ThemeData themeData) {
    return themeData.textTheme.bodyText2!;
  }

  static TextStyle pageTitle(final ThemeData themeData) {
    return themeData.textTheme.headline3!;
  }

  static TextStyle pageSubtitle(final ThemeData themeData) {
    return themeData.textTheme.bodyText1!;
  }

  static TextStyle menuButtonLabel(final ThemeData themeData) {
    return themeData.textTheme.headline6!;
  }

  static TextStyle cumulatedText(final ThemeData themeData, final Color color) {
    return themeData.textTheme.headlineLarge!.copyWith(color: color);
  }

  static TextStyle saveButtonText(final ThemeData themeData) {
    return themeData.textTheme.headline4!;
  }

  static TextStyle didLearnDayText(final ThemeData themeData) {
    return themeData.textTheme.subtitle1!;
  }

  static TextStyle didNotLearnDayText(final ThemeData themeData) {
    return themeData.textTheme.subtitle2!;
  }

  static TextStyle monthAndYear(final ThemeData themeData) {
    return themeData.textTheme.headline4!.copyWith(fontSize: 26);
  }

  static TextStyle contentTitle(final ThemeData themeData) {
    return themeData.textTheme.headline4!;
  }

  static TextStyle description(final ThemeData themeData) {
    return themeData.textTheme.bodyText1!;
  }

  static TextStyle paragraphTitle(final ThemeData themeData) {
    return themeData.textTheme.headline4!;
  }

  static TextStyle dayAbbreviation(final ThemeData themeData) {
    return themeData.textTheme.labelMedium!;
  }

  static TextStyle radioSelectorTitle(final ThemeData themeData) {
    return themeData.textTheme.headline4!;
  }

  static TextStyle radioInfo(final ThemeData themeData) {
    return themeData.textTheme.bodyText1!;
  }

  static TextStyle radioLabel(final ThemeData themeData, final Color color) {
    return themeData.textTheme.headline2!.copyWith(color: color);
  }

  static TextStyle dateOfDayMainText(final ThemeData themeData) {
    return themeData.textTheme.headline1!;
  }

  static TextStyle dateOfDayMinorText(final ThemeData themeData) {
    return themeData.textTheme.headline5!;
  }
}
