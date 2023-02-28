import 'dart:math';

import 'package:flutter/material.dart';

class SizeUtil {
  static double get menuMargin => 20.0;
  static double get menuIcon => 50.0;
  static double get routeButtonBoxWidth => 60.0;
  static double get routeIcon => 40.0;

  static double get menuButtonBoxWidth => 60.0;
  static double get menuContainerHeight => 120.0;
  static double get maxMenuContainerWidth => 360.0;

  static double get appBar => 40.0;

  static double get calendarWidthFraction => 0.90;

  static double get infoTextWidthFraction => 0.70;

  static double get evaluationIconSize => 80.0;
  static double get paragraphWidthFraction => 0.8;
  static double get infoPageItemWidthOuterFraction => 0.9;
  static double get infoPageItemWidthInnerFraction => 0.5;
  static double get infoPageItemHeightFraction => 0.65;

  static double get changeMonthArrowIcon => 45.0;
  static double get cumulatedIcon => 42.0;
  static double get emptyScrollEnd => 200.0;
  static double get contentLocationPointer => 15.0;
  static double get borderRadius => 10.0;

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

  static double getParagraphTextWidth(final BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * paragraphWidthFraction;
  }

  static double getInfoPageItemMaxOuterWidth(final BuildContext context) {
    return MediaQuery.of(context).size.width * infoPageItemWidthOuterFraction;
  }

  static double getInfoPageItemMaxInnerWidth(final BuildContext context) {
    return MediaQuery.of(context).size.width * infoPageItemWidthInnerFraction;
  }

  static double getInfoPageItemMaxHeight(final BuildContext context) {
    return MediaQuery.of(context).size.height * infoPageItemHeightFraction;
  }
}
