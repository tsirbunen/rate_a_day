import 'package:flutter/material.dart';
import 'dart:math';
import 'package:rate_a_day/packages/pages.dart';

class ExpandedButton extends StatelessWidget {
  final dynamic onPressed;
  final double directionInDegrees;
  final double maxDistance = 150;
  final Animation<double> progress;
  final String routeName;

  const ExpandedButton({
    Key? key,
    required this.onPressed,
    required this.directionInDegrees,
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

    final Widget child = Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: themeData.colorScheme.primaryContainer,
      elevation: 10.0,
      child: IconButton(
        key: ValueKey('menu_button_$routeName'),
        onPressed: onPressed,
        iconSize: 40.0,
        icon: _buildIcon(themeData),
      ),
    );

    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
            directionInDegrees * (pi / 180.0), progress.value * maxDistance);
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
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
