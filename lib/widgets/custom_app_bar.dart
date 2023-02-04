import 'package:flutter/material.dart';

import 'package:rate_a_day/packages/pages.dart';

const routeDisplayNames = {
  '/': 'today page',
  Calendar.routeName: 'calendar',
  Today.routeName: 'today page',
  Settings.routeName: 'settings page',
  Info.routeName: 'info page',
};

const height = 80.0;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);
  final Size _preferredSize = const Size.fromHeight(height);

  String _getPageDisplayName(final BuildContext context) {
    final String pageName = ModalRoute.of(context)?.settings.name ?? '';
    print(pageName);
    if (pageName.isNotEmpty && routeDisplayNames.containsKey(pageName)) {
      return routeDisplayNames[pageName]!;
    }
    return '';
  }

  @override
  Widget build(final BuildContext context) {
    const String appTitle = 'RATE A DAY';
    final ThemeData themeData = Theme.of(context);

    final String displayName = _getPageDisplayName(context);

    return PreferredSize(
        child: AppBar(
          backgroundColor: themeData.colorScheme.primaryContainer,
          elevation: 10,
          centerTitle: true,
          toolbarHeight: height,
          automaticallyImplyLeading: false,
          title: SizedBox(
            height: height,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(appTitle,
                  style: themeData.textTheme.headline3?.copyWith(
                      color: themeData.colorScheme.onPrimaryContainer)),
              Text(displayName, style: themeData.textTheme.headline4),
            ]),
          ),
        ),
        preferredSize: _preferredSize);
  }

  @override
  Size get preferredSize => _preferredSize;
}
