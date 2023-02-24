import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/localizations.dart';
import 'package:rate_a_day/packages/pages.dart';
import 'package:rate_a_day/packages/utils.dart';

final Map<String, Phrase> routes = {
  '/': Phrase.routeToday,
  Month.routeName: Phrase.routeMonth,
  Today.routeName: Phrase.routeToday,
  Settings.routeName: Phrase.routeSettings,
  Info.routeName: Phrase.routeInfo,
};

const double titleContainerHeight = 40;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  final Size _preferredSize = const Size.fromHeight(titleContainerHeight);

  @override
  Widget build(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final String appTitle = context.translate(Phrase.appTitle);

    final Color textColor = themeData.colorScheme.onSecondaryContainer;

    return PreferredSize(
        child: AppBar(
          backgroundColor: themeData.colorScheme.secondaryContainer,
          elevation: ScreenSizeUtil.generalElevation,
          centerTitle: true,
          toolbarHeight: titleContainerHeight,
          automaticallyImplyLeading: false,
          title: SizedBox(
            height: titleContainerHeight,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(appTitle,
                      textAlign: TextAlign.center,
                      style: themeData.textTheme.headline5
                          ?.copyWith(color: textColor)),
                ]),
          ),
        ),
        preferredSize: _preferredSize);
  }

  @override
  Size get preferredSize => _preferredSize;
}
