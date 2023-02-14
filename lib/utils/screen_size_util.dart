import 'dart:math';

import 'package:flutter/material.dart';

class ScreenSizeUtil {
  static double get menuMargin => 20.0;
  static double get routeButtonBoxWidth => 60;
  static double get generalMargin => 10.0;
  static double get menuButtonBoxWidth => 60.0;
  static double get menuContainerHeight => 120.0;
  static double get maxMenuContainerWidth => 360.0;

  static double get appBarHeight => 150.0;
  static double get generalElevation => 10.0;

  static double get calendarWidthFraction => 0.80;

  static double get infoTextWidthFraction => 0.70;

  static double get evaluationIconSize => 80.0;

  static double get infoPageItemFraction => 0.8;

  static double getFullWidth(final BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getMenuContainerWidth(final BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return min(screenWidth - 2 * ScreenSizeUtil.menuMargin,
        ScreenSizeUtil.maxMenuContainerWidth);
  }

  static double getMenuContainerRightMargin(final BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double menuContainerWidth =
        ScreenSizeUtil.getMenuContainerWidth(context);
    return (screenWidth - menuContainerWidth) / 2;
  }

  static double getCalendarWidth(final BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * calendarWidthFraction;
  }

  static double getInfoTextWidth(final BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * infoTextWidthFraction;
  }

  static double getInfoPageItemMaxWidth(final BuildContext context) {
    return MediaQuery.of(context).size.width * infoPageItemFraction;
  }
}
