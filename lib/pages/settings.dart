import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rate_a_day/packages/localizations.dart';

class Settings extends StatelessWidget {
  static const routeName = '/settings';

  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final String title = context.translate(Phrase.settingsTitle);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Container(
          color: themeData.colorScheme.background,
          width: ScreenSizeUtil.getFullWidth(context),
          child: Container(
            margin: const EdgeInsets.only(left: 20.0, top: 20.0),
            child: Column(
              children: [
                PageTitle(title: title),
                const SelectLanguage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
