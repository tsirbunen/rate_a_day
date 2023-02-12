import 'package:flutter/material.dart';
import 'package:rate_a_day/main.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rate_a_day/packages/pages.dart';

class ExpandableFloatingMenu extends StatefulWidget {
  const ExpandableFloatingMenu({Key? key}) : super(key: key);

  @override
  State<ExpandableFloatingMenu> createState() => _ExpandableFloatingMenuState();
}

class _ExpandableFloatingMenuState extends State<ExpandableFloatingMenu>
    with SingleTickerProviderStateMixin {
  bool _areExpanded = false;
  late final AnimationController _controller;
  late final Animation<double> _expansion;
  final Duration _duration = const Duration(milliseconds: 600);

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(value: 0.0, vsync: this, duration: _duration);
    _expansion = CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.easeOutQuad);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _areExpanded = !_areExpanded;
      if (_areExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _navigateToRoute(String targetRoute) {
    final NavigatorState? navigatorState = navigatorKey.currentState;
    if (navigatorState == null) return;
    navigatorState.pushReplacementNamed(targetRoute);
  }

  List<Widget> _buildExpandedButtons() {
    final List<String> routeNames = [
      Info.routeName,
      Settings.routeName,
      Calendar.routeName,
      Today.routeName,
    ];
    final List<ExpandedButton> buttons = [];

    double menuWidth = ScreenSizeUtil.getMenuContainerWidth(context);
    final double routeButtonWidth = ScreenSizeUtil.routeButtonBoxWidth;
    const double spacer = 10.0;
    final List<double> targetLocations = [
      menuWidth - routeButtonWidth,
      menuWidth - routeButtonWidth * 2 - spacer,
      routeButtonWidth + spacer,
      0
    ];

    for (var i = 0; i < routeNames.length; i++) {
      final String routeName = routeNames[i];
      buttons.add(
        ExpandedButton(
            onPressed: () => _navigateToRoute(routeName),
            targetLocation: targetLocations[i],
            progress: _expansion,
            routeName: routeName),
      );
    }
    return buttons.toList();
  }

  Widget _buildFloatingMenuButton(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final IconData iconData =
        _areExpanded ? Icons.close_rounded : Icons.menu_rounded;
    return AnimatedBuilder(
      animation: _expansion,
      builder: (context, child) {
        return child!;
      },
      child: SizedBox(
        width: ScreenSizeUtil.menuButtonBoxWidth,
        height: ScreenSizeUtil.menuButtonBoxWidth,
        child: FloatingActionButton(
          onPressed: _toggleExpansion,
          backgroundColor: themeData.colorScheme.secondaryContainer,
          elevation: 10,
          child: Icon(
            iconData,
            size: 50,
            color: themeData.colorScheme.onSecondaryContainer,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double menuWidth = ScreenSizeUtil.getMenuContainerWidth(context);

    return SizedBox(
      width: menuWidth,
      height: ScreenSizeUtil.menuContainerHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ..._buildExpandedButtons(),
          _buildFloatingMenuButton(context),
        ],
      ),
    );
  }
}
