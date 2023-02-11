import 'dart:math';

import 'package:flutter/material.dart';

class ScreenSizeUtil {
  static double get menuMargin => 20.0;
  static double get routeButtonBoxWidth => 60;
  static double get generalMargin => 10.0;
  static double get menuButtonBoxWidth => 70.0;
  static double get menuContainerHeight => 80.0;
  static double get maxMenuContainerWidth => 380.0;

  static double get appBarHeight => 80.0;
  static double get generalElevation => 10.0;

  static double get calendarWidthFraction => 0.80;

  static double get infoTextWidthFraction => 0.70;

  static double get evaluationIconSize => 80.0;

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
}
