import 'package:flutter/material.dart';
import 'dart:math';
import 'package:rate_a_day/packages/pages.dart';
import 'package:rate_a_day/packages/utils.dart';

class ExpandedButton extends StatelessWidget {
  final dynamic onPressed;
  final double targetLocation;
  final Animation<double> progress;
  final String routeName;

  const ExpandedButton({
    Key? key,
    required this.onPressed,
    required this.targetLocation,
    required this.progress,
    required this.routeName,
  }) : super(key: key);

  Widget _buildIcon(final ThemeData themeData) {
    IconData iconData;
    switch (routeName) {
      case Calendar.routeName:
        iconData = Icons.calendar_month;
        break;
      case Today.routeName:
        iconData = Icons.today;
        break;
      case Settings.routeName:
        iconData = Icons.settings_outlined;
        break;
      case Info.routeName:
        iconData = Icons.info_outline;
        break;
      default:
        throw Exception('Icon for route name $routeName not available!');
    }

    return Icon(
      iconData,
      color: themeData.colorScheme.onPrimaryContainer,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double menuWidth = ScreenSizeUtil.getMenuContainerWidth(screenWidth);
    final double startingPoint =
        (menuWidth - ScreenSizeUtil.routeButtonBoxWidth) / 2;

    final Widget child = Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: themeData.colorScheme.primaryContainer,
      elevation: 10.0,
      child: SizedBox(
        width: ScreenSizeUtil.routeButtonBoxWidth,
        height: ScreenSizeUtil.routeButtonBoxWidth,
        child: IconButton(
          key: ValueKey('menu_button_$routeName'),
          onPressed: onPressed,
          iconSize: 40.0,
          icon: _buildIcon(themeData),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final double offset = progress.value * (targetLocation - startingPoint);
        return Positioned(
          right: startingPoint + offset,
          bottom: 10.0,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * pi / 2.0,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}
