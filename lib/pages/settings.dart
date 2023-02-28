import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rate_a_day/packages/localizations.dart';

class Settings extends StatelessWidget with Constants {
  static const routeName = '/settings';

  Settings({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final String title = context.translate(Phrase.settingsTitle);

    return PageScaffold(
        child: SizedBox(
      width: SizeUtil.getFullWidth(context),
      height: MediaQuery.of(context).size.height,
      child: Container(
        margin: EdgeInsets.only(
          left: paddingL,
          right: paddingS,
        ),
        child: Column(
          children: [
            PageTitle(title: title),
            SelectLanguage(),
          ],
        ),
      ),
    ));
  }
}
