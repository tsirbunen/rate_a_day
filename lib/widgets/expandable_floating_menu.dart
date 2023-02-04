import 'package:flutter/material.dart';
import 'package:rate_a_day/main.dart';
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
  final Duration _duration = const Duration(milliseconds: 400);

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
    navigatorState.pushNamed(targetRoute);
    _toggleExpansion();
  }

  List<Widget> _buildExpandedButtons() {
    final List<String> routeNames = [
      Calendar.routeName,
      Today.routeName,
      Settings.routeName,
      Info.routeName
    ];
    final List<ExpandedButton> buttons = [];
    final double stepDegrees = 90.0 / (routeNames.length - 1);
    var angleInDegrees = 0.0;
    for (var i = 0; i < routeNames.length; i++) {
      final String routeName = routeNames[i];
      buttons.add(
        ExpandedButton(
            onPressed: () => _navigateToRoute(routeName),
            directionInDegrees: angleInDegrees,
            progress: _expansion,
            routeName: routeName),
      );
      angleInDegrees += stepDegrees;
    }
    return buttons.toList();
  }

  Widget _buildFloatingMenuButton(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return AnimatedBuilder(
      animation: _expansion,
      builder: (context, child) {
        return child!;
      },
      child: SizedBox(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          onPressed: _toggleExpansion,
          backgroundColor: themeData.colorScheme.primaryContainer,
          child: Icon(
            Icons.menu_rounded,
            size: 50,
            color: themeData.colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 350,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ..._buildExpandedButtons(),
          _buildFloatingMenuButton(context),
        ],
      ),
    );
  }
}
