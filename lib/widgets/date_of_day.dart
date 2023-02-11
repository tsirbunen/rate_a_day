import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/utils.dart';

class DateOfDay extends StatelessWidget {
  const DateOfDay({Key? key}) : super(key: key);

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
          final String minorText =
              focusIsToday ? date : DateTimeUtil.getWeekday(focusDate);

          return Column(
            children: [
              Text(minorText,
                  style: themeData.textTheme.headline2
                      ?.copyWith(color: themeData.colorScheme.secondary)),
              Text(mainText,
                  style: themeData.textTheme.headline1
                      ?.copyWith(color: themeData.colorScheme.primary)),
            ],
          );
        });
  }
}
