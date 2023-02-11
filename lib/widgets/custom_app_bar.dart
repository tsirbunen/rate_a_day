import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/pages.dart';
import 'package:rate_a_day/packages/utils.dart';

final Map<String, Phrase> routes = {
  '/': Phrase.routeToday,
  Calendar.routeName: Phrase.routeCalendar,
  Today.routeName: Phrase.routeToday,
  Settings.routeName: Phrase.routeSettings,
  Info.routeName: Phrase.routeInfo,
};

final double height = ScreenSizeUtil.appBarHeight;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key}) : super(key: key);

  final Size _preferredSize = Size.fromHeight(height);

  String _getPageDisplayName(final BuildContext context, final translate) {
    final String pageName = ModalRoute.of(context)?.settings.name ?? '';
    if (pageName.isNotEmpty && routes.containsKey(pageName)) {
      return translate(routes[pageName]!);
    }
    return '';
  }

  @override
  Widget build(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    final String appTitle = settingsBloc.translate(Phrase.appTitle);

    final String displayName =
        _getPageDisplayName(context, settingsBloc.translate);
    final Color textColor = themeData.colorScheme.onSecondaryContainer;

    return PreferredSize(
        child: AppBar(
          backgroundColor: themeData.colorScheme.secondaryContainer,
          elevation: ScreenSizeUtil.generalElevation,
          centerTitle: true,
          toolbarHeight: height,
          automaticallyImplyLeading: false,
          title: SizedBox(
            height: height,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(appTitle,
                  style: themeData.textTheme.headline3
                      ?.copyWith(color: textColor)),
              Text(displayName,
                  style: themeData.textTheme.headline4
                      ?.copyWith(color: textColor)),
            ]),
          ),
        ),
        preferredSize: _preferredSize);
  }

  @override
  Size get preferredSize => _preferredSize;
}
