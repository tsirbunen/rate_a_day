import 'package:flutter/material.dart';
import 'package:rate_a_day/main.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/pages.dart';
import 'package:rate_a_day/packages/utils.dart';

class DateOfDay extends StatelessWidget {
  const DateOfDay({Key? key}) : super(key: key);

  void _handleTappedDate() {
    final NavigatorState? navigatorState = navigatorKey.currentState;
    if (navigatorState == null) return;
    navigatorState.pushReplacementNamed(Calendar.routeName);
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
          );
        });
  }
}
