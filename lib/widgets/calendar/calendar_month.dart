import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/widgets.dart';

class CalendarMonth extends StatelessWidget {
  final DateTime focusDate;
  const CalendarMonth({Key? key, required this.focusDate}) : super(key: key);

  TableRow _buildDayLabelRow(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Locale currentLocale = Localizations.localeOf(context);
    final List<String> dayAbbreviations =
        DateTimeUtil.getDayAbbreviations(currentLocale);
    final TextStyle style = StyleUtil.dayAbbreviation(themeData);

    return TableRow(
      children: dayAbbreviations
          .map((day) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day,
                    style: style,
                  ),
                ],
              ))
          .toList(),
    );
  }

  TableRow _buildWeek(final BuildContext context, final List<int?> days,
      final BuiltMap<int, DayData> dayData) {
    return TableRow(
      children: days.map((final int? day) {
        if (day == null) return Container();
        final data = dayData.containsKey(day) ? dayData[day] : null;
        return CalendarDay(
          day: day,
          dayData: data,
        );
      }).toList(),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);

    return StreamBuilder<BuiltMap<int, DayData>>(
        stream: dataBloc.monthsData,
        builder: (final BuildContext context,
            AsyncSnapshot<BuiltMap<int, DayData>> dayDataSnapshot) {
          final double gridSize = SizeUtil.getCalendarWidth(context);
          final BuiltMap<int, DayData> dayDataByDay = dayDataSnapshot.hasData
              ? dayDataSnapshot.data!
              : BuiltMap.from({});

          final List<List<int?>> daysOfMonth =
              DateTimeUtil.arrangeDaysOfMonth(focusDate);

          return SizedBox(
            width: gridSize,
            child: Table(
              border: TableBorder.symmetric(
                  inside: BorderSide(
                      width: 1.0,
                      color: themeData.colorScheme.primaryContainer)),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                _buildDayLabelRow(context),
                ...daysOfMonth.map((week) {
                  return _buildWeek(context, week, dayDataByDay);
                }),
              ],
            ),
          );
        });
  }
}
