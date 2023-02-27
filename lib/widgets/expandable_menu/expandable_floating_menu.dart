import 'package:flutter/material.dart';
import 'package:rate_a_day/main.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rate_a_day/packages/pages.dart';
import 'package:rate_a_day/packages/localizations.dart';

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

  void _navigateToRoute(final BuildContext context, String targetRoute) {
    final NavigatorState? navigatorState = navigatorKey.currentState;
    if (navigatorState == null) return;
    if (targetRoute == Today.routeName) {
      final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
      dataBloc.changeFocusDate(DateTime.now());
    }
    navigatorState.pushReplacementNamed(targetRoute);
    _toggleExpansion();
  }

  List<Widget> _buildExpandedButtons(final BuildContext context) {
    double menuWidth = SizeUtil.getMenuContainerWidth(context);
    final List<List<dynamic>> routeData = [
      [
        Info.routeName,
        context.translate(Phrase.navigationInfo),
        menuWidth * 3 / 4
      ],
      [
        Settings.routeName,
        context.translate(Phrase.navigationSettings),
        menuWidth / 2
      ],
      [
        Month.routeName,
        context.translate(Phrase.navigationMonth),
        menuWidth / 4
      ],
      [Today.routeName, context.translate(Phrase.navigationToday), 0.0],
    ];
    return routeData.map((final List<dynamic> route) {
      return ExpandedButton(
        onPressed: () => _navigateToRoute(context, route[0]),
        targetLocation: route[2],
        progress: _expansion,
        routeName: route[0],
        label: route[1],
      );
    }).toList();
  }

  Widget _buildFloatingMenuButton(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle labelStyle = StyleUtil.menuButtonLabel(themeData);
    final Color menuIconColor = StyleUtil.menuButtonIcon(themeData);
    final Color menuBackgroundColor = StyleUtil.menuButtonBackground(themeData);

    final double size = SizeUtil.menuButtonBoxWidth;
    double menuWidth = SizeUtil.getMenuContainerWidth(context);
    final double position = (menuWidth - SizeUtil.routeButtonBoxWidth) / 2;
    final Widget child = Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: menuBackgroundColor,
      elevation: SizeUtil.generalMargin,
      child: SizedBox(
        width: size,
        height: size,
        child: FloatingActionButton(
          onPressed: _toggleExpansion,
          backgroundColor: menuBackgroundColor,
          elevation: SizeUtil.generalElevation,
          child: Icon(
            Icons.menu_rounded,
            size: SizeUtil.menuIcon,
            color: menuIconColor,
          ),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _expansion,
      builder: (context, child) {
        return Positioned(
            right: position, bottom: SizeUtil.generalMargin, child: child!);
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
                padding: EdgeInsets.only(top: SizeUtil.generalMargin),
                child: Text(
                  context.translate(Phrase.navigationMenu),
                  style: labelStyle,
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
    double menuWidth = SizeUtil.getMenuContainerWidth(context);
    return SizedBox(
      width: menuWidth,
      height: SizeUtil.menuContainerHeight,
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
