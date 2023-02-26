import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rate_a_day/packages/localizations.dart';

class Settings extends StatelessWidget {
  static const routeName = '/settings';

  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final String title = context.translate(Phrase.settingsTitle);

    return PageScaffold(
        child: SizedBox(
      width: SizeUtil.getFullWidth(context),
      height: MediaQuery.of(context).size.height,
      child: Container(
        margin: EdgeInsets.only(
          left: SizeUtil.paddingLarge,
          right: SizeUtil.paddingSmall,
        ),
        child: Column(
          children: [
            PageTitle(title: title),
            const SelectLanguage(),
          ],
        ),
      ),
    ));
  }
}
