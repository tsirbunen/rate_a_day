import 'dart:math';

import 'package:flutter/material.dart';

class SizeUtil {
  static double get generalMargin => 10.0;
  static double get generalElevation => 10.0;
  static double get paddingSmall => 10.0;
  static double get paddingLarge => 20.0;

  static double get menuMargin => 20.0;
  static double get menuIcon => 50.0;
  static double get routeButtonBoxWidth => 60.0;
  static double get routeIcon => 40.0;
  // static double get routeFont => 15.0;
  static double get menuButtonBoxWidth => 60.0;
  static double get menuContainerHeight => 120.0;
  static double get maxMenuContainerWidth => 360.0;

  static double get appBar => 40.0;

  static double get calendarWidthFraction => 0.90;

  static double get infoTextWidthFraction => 0.70;

  static double get evaluationIconSize => 80.0;

  static double get infoPageItemFraction => 0.8;

  static double get changeMonthArrowIcon => 45.0;

  static double getFullWidth(final BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getMenuContainerWidth(final BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return min(
        screenWidth - 2 * SizeUtil.menuMargin, SizeUtil.maxMenuContainerWidth);
  }

  static double getMenuContainerRightMargin(final BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double menuContainerWidth = SizeUtil.getMenuContainerWidth(context);
    return (screenWidth - menuContainerWidth) / 2;
  }

  static double getCalendarWidth(final BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double textScaleFactor =
        MediaQuery.maybeOf(context)?.textScaleFactor ?? 1.0;
    if (textScaleFactor > 1.0) return screenWidth;
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
