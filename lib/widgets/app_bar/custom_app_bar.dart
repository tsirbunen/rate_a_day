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

class CustomAppBar extends StatelessWidget
    with Constants
    implements PreferredSizeWidget {
  CustomAppBar({Key? key}) : super(key: key);

  final Size _preferredSize = Size.fromHeight(SizeUtil.appBar);

  @override
  Widget build(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final String appTitle = context.translate(Phrase.appTitle);
    final TextStyle style = StyleUtil.appTitle(themeData);
    final Color appBarColor = StyleUtil.appBar(themeData);

    return PreferredSize(
        child: AppBar(
          backgroundColor: appBarColor,
          elevation: elevation,
          centerTitle: true,
          toolbarHeight: SizeUtil.appBar,
          automaticallyImplyLeading: false,
          title: SizedBox(
            height: SizeUtil.appBar,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(appTitle, textAlign: TextAlign.center, style: style),
                ]),
          ),
        ),
        preferredSize: _preferredSize);
  }

  @override
  Size get preferredSize => _preferredSize;
}
