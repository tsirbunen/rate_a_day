import 'package:flutter/material.dart';
import 'package:rate_a_day/main.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/pages.dart';
import 'package:rate_a_day/packages/utils.dart';

class DateOfDayButton extends StatelessWidget {
  const DateOfDayButton({Key? key}) : super(key: key);

  void _handleTappedDate() {
    final NavigatorState? navigatorState = navigatorKey.currentState;
    if (navigatorState == null) return;
    navigatorState.pushReplacementNamed(Month.routeName);
  }

  @override
  Widget build(final BuildContext context) {
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    final SettingsBloc settings = BlocProvider.of<SettingsBloc>(context);
    final ThemeData themeData = Theme.of(context);

    return StreamBuilder<DateTime>(
        stream: dataBloc.focusDate,
        builder:
            (final BuildContext context, AsyncSnapshot<DateTime> snapshot) {
          final DateTime focusDate =
              snapshot.hasData ? snapshot.data! : DateTime.now();
          final DateTime today = DateTime.now();
          final bool focusIsToday = DateTimeUtil.areSameDate(focusDate, today);
          final String date = DateTimeUtil.getDate(focusDate);
          final String mainText = focusIsToday
              ? settings.translate(Phrase.today).toUpperCase()
              : date;
          final String minorText = focusIsToday
              ? date
              : DateTimeUtil.getWeekday(focusDate, settings.translator);

          return GestureDetector(
            onTap: _handleTappedDate,
            child: Container(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
              decoration: BoxDecoration(
                color: themeData.colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Text(minorText,
                      style: themeData.textTheme.headline5
                          ?.copyWith(color: themeData.colorScheme.secondary)),
                  Text(mainText,
                      style: themeData.textTheme.headline1
                          ?.copyWith(color: themeData.colorScheme.primary)),
                ],
              ),
            ),
          );
        });
  }
}
