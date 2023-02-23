import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rate_a_day/packages/localizations.dart';

class Month extends StatelessWidget {
  static const routeName = '/month';

  const Month({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final String title = context.translate(Phrase.monthTitle);
    final String subtitle = context.translate(Phrase.monthSubtitle);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Container(
          color: themeData.colorScheme.background,
          child: Center(
            child: Column(
              children: [
                PageTitle(title: title),
                PageSubtitle(subtitle: subtitle),
                const Calendar(),
                const CalendarStatistics(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
