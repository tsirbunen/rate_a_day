import 'package:flutter/material.dart';
import 'package:rate_a_day/main.dart';
import 'package:rate_a_day/packages/blocs.dart';
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
  bool _showMenu = true;

  late final AnimationController _controller;
  late final Animation<double> _expansion;
  final Duration _duration = const Duration(milliseconds: 300);

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
        _controller.forward().whenComplete(() => setState(() {
              _showMenu = false;
            }));
      } else {
        _controller.reverse().whenComplete(() => setState(() {
              _showMenu = true;
            }));
      }
    });
  }

  void _navigateToRoute(String targetRoute) {
    final NavigatorState? navigatorState = navigatorKey.currentState;
    if (navigatorState == null) return;
    navigatorState.pushReplacementNamed(targetRoute);
    _toggleExpansion();
  }

  List<Widget> _buildExpandedButtons(final BuildContext context) {
    final SettingsBloc settings = BlocProvider.of<SettingsBloc>(context);
    double menuWidth = ScreenSizeUtil.getMenuContainerWidth(context);
    final List<List<dynamic>> routeData = [
      [
        Info.routeName,
        settings.translate(Phrase.navigationInfo),
        menuWidth * 3 / 4
      ],
      [
        Settings.routeName,
        settings.translate(Phrase.navigationSettings),
        menuWidth / 2
      ],
      [
        Calendar.routeName,
        settings.translate(Phrase.navigationMonth),
        menuWidth / 4
      ],
      [Today.routeName, settings.translate(Phrase.navigationToday), 0.0],
    ];
    return routeData.map((final List<dynamic> route) {
      return ExpandedButton(
        onPressed: () => _navigateToRoute(route[0]),
        targetLocation: route[2],
        progress: _expansion,
        routeName: route[0],
        label: route[1],
      );
    }).toList();
  }

  Widget _buildFloatingMenuButton(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final SettingsBloc settings = BlocProvider.of<SettingsBloc>(context);

    final double size = ScreenSizeUtil.menuButtonBoxWidth;
    double menuWidth = ScreenSizeUtil.getMenuContainerWidth(context);
    final double position =
        (menuWidth - ScreenSizeUtil.routeButtonBoxWidth) / 2;
    final Widget child = Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: themeData.colorScheme.secondaryContainer,
      elevation: 10.0,
      child: SizedBox(
        width: size,
        height: size,
        child: FloatingActionButton(
          onPressed: _toggleExpansion,
          backgroundColor: themeData.colorScheme.secondaryContainer,
          elevation: 10,
          child: Icon(
            Icons.menu_rounded,
            size: 50,
            color: themeData.colorScheme.onSecondaryContainer,
          ),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _expansion,
      builder: (context, child) {
        return Positioned(right: position, bottom: 10.0, child: child!);
      },
      child: AnimatedOpacity(
        opacity: _areExpanded ? 0.0 : 1.0,
        duration: _duration,
        child: Column(
          children: [
            child,
            Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  settings.translate(Phrase.navigationMenu),
                  style: themeData.textTheme.headline6?.copyWith(
                      color: themeData.colorScheme.secondaryContainer,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
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
          ..._buildExpandedButtons(context),
          if (_showMenu) _buildFloatingMenuButton(context),
        ],
      ),
    );
  }
}
