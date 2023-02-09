import 'dart:math';

class ScreenSizeUtil {
  static double get menuMargin => 20.0;
  static double get routeButtonBoxWidth => 60;
  static double get generalMargin => 10.0;
  static double get menuButtonBoxWidth => 70.0;
  static double get menuContainerHeight => 80.0;
  static double get maxMenuContainerWidth => 380.0;

  static double getMenuContainerWidth(final double screenWidth) {
    return min(screenWidth - 2 * ScreenSizeUtil.menuMargin,
        ScreenSizeUtil.maxMenuContainerWidth);
  }

  static double getMenuContainerRightMargin(final double screenWidth) {
    final double menuContainerWidth =
        ScreenSizeUtil.getMenuContainerWidth(screenWidth);
    return (screenWidth - menuContainerWidth) / 2;
  }
}
