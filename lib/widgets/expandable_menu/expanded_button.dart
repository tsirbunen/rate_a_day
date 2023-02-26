import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/pages.dart';
import 'package:rate_a_day/packages/utils.dart';

class ExpandedButton extends StatelessWidget {
  final dynamic onPressed;
  final double targetLocation;
  final Animation<double> progress;
  final String routeName;
  final String label;

  const ExpandedButton({
    Key? key,
    required this.onPressed,
    required this.targetLocation,
    required this.progress,
    required this.routeName,
    required this.label,
  }) : super(key: key);

  Widget _buildRouteIcon(final ThemeData themeData) {
    IconData iconData;
    switch (routeName) {
      case Month.routeName:
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
      color: themeData.colorScheme.onSecondaryContainer,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    double menuWidth = SizeUtil.getMenuContainerWidth(context);
    final double startingPoint = (menuWidth - SizeUtil.routeButtonBoxWidth) / 2;

    final Widget child = Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: themeData.colorScheme.secondaryContainer,
      elevation: SizeUtil.generalElevation,
      child: SizedBox(
        width: SizeUtil.routeButtonBoxWidth,
        height: SizeUtil.routeButtonBoxWidth,
        child: IconButton(
          key: ValueKey('menu_button_$routeName'),
          onPressed: onPressed,
          iconSize: SizeUtil.routeIcon,
          icon: _buildRouteIcon(themeData),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final double offset = progress.value * (targetLocation - startingPoint);
        return Positioned(
          right: startingPoint + offset,
          bottom: SizeUtil.generalMargin,
          child: child!,
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: SizedBox(
          width: SizeUtil.getMenuContainerWidth(context) / 4,
          child: Column(
            children: [
              child,
              Material(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.only(top: SizeUtil.generalMargin),
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: themeData.textTheme.headline6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
