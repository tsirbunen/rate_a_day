import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rate_a_day/main.dart';
import 'package:rate_a_day/pages/today.dart';

class Calendar extends StatelessWidget {
  static const routeName = '/calendar';

  const Calendar({Key? key}) : super(key: key);

  Widget _buildDay(
      final BuildContext context, final int day, final DayData? dayData) {
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    final ThemeData themeData = Theme.of(context);
    final bool didLearnNew = dayData != null ? dayData.didLearnNew : false;
    final Color dayNumberColor = didLearnNew
        ? themeData.colorScheme.onTertiary
        : themeData.colorScheme.primaryContainer;
    final Color assessmentColor = dayData == null
        ? Colors.transparent
        : dayData.rating == Rating.HAPPY
            ? Evaluations.getColor(Evaluation.satisfied, themeData)
            : Evaluations.getColor(Evaluation.dissatisfied, themeData);

    final bool ratingIsMissing =
        dayData == null || dayData.rating == Rating.MISSING;
    BoxDecoration? decoration;
    if (ratingIsMissing) {
      decoration = BoxDecoration(
        border: Border.all(
            color: themeData.colorScheme.primaryContainer, width: 2.0),
        shape: BoxShape.circle,
      );
    } else {
      decoration = null;
    }

    Widget child;
    if (ratingIsMissing) {
      child = Icon(
        Evaluations.getIcon(Evaluation.satisfied),
        color: Colors.transparent,
        size: 36,
      );
    } else {
      child = Icon(
        dayData.rating == Rating.HAPPY
            ? Evaluations.getIcon(Evaluation.satisfied)
            : Evaluations.getIcon(Evaluation.dissatisfied),
        color: assessmentColor,
        size: 50,
      );
    }

    return StreamBuilder<DateTime>(
        stream: dataBloc.focusDate,
        builder:
            (final BuildContext context, AsyncSnapshot<DateTime> snapshot) {
          final DateTime focusDate =
              snapshot.hasData ? snapshot.data! : DateTime.now();
          final DateTime newFocusDate =
              DateTime(focusDate.year, focusDate.month, day);
          final bool isDisabled = (newFocusDate.compareTo(DateTime.now()) > 0);
          final void Function() onTap = isDisabled
              ? () {}
              : () => _handleTappedDay(newFocusDate, dataBloc.changeFocusDate);
          return SizedBox(
            width: 60,
            height: 66,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Text(day.toString(),
                    style: themeData.textTheme.headline6?.copyWith(
                        color: dayNumberColor, fontWeight: FontWeight.bold)),
                Container(
                  margin: EdgeInsets.only(top: ratingIsMissing ? 21.0 : 16.0),
                  child: Material(
                    type: MaterialType.transparency,
                    child: Ink(
                      decoration: decoration,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(52.0),
                        onTap: onTap,
                        child: child,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _handleTappedDay(
      final DateTime newFocusDate, final Function changeFocusDate) {
    final NavigatorState? navigatorState = navigatorKey.currentState;
    if (navigatorState == null) return;
    changeFocusDate(newFocusDate);
    navigatorState.pushNamed(Today.routeName);
  }

  TableRow _buildDayLabelRow(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final List<String> dayAbbreviations = ['M', 'T', 'K', 'T', 'P', 'L', 'S'];

    return TableRow(
      children: dayAbbreviations
          .map((day) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day,
                    style: themeData.textTheme.headline5?.copyWith(
                      color: themeData.colorScheme.primaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
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
        return _buildDay(context, day, data);
      }).toList(),
    );
  }

  Widget _buildCalendar(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);

    return StreamBuilder<BuiltMap<int, DayData>>(
        stream: dataBloc.monthsData,
        builder: (final BuildContext context,
            AsyncSnapshot<BuiltMap<int, DayData>> dayDataSnapshot) {
          final double screenWidth = MediaQuery.of(context).size.width;
          final double gridSize = screenWidth * 0.80;
          final BuiltMap<int, DayData> dayDataByDay = dayDataSnapshot.hasData
              ? dayDataSnapshot.data!
              : BuiltMap.from({});

          return StreamBuilder<DateTime>(
              stream: dataBloc.focusDate,
              builder: (final BuildContext context,
                  AsyncSnapshot<DateTime> focusDateSnapshot) {
                final DateTime focusDate = focusDateSnapshot.hasData
                    ? focusDateSnapshot.data!
                    : DateTime.now();
                final List<List<int?>> daysOfMonth =
                    DateTimeUtil.arrangeDaysOfMonth(focusDate);

                return Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: gridSize,
                    child: Table(
                      border: TableBorder.symmetric(
                          inside: BorderSide(
                              width: 1.0,
                              color: themeData.colorScheme.primaryContainer)),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: <TableRow>[
                        _buildDayLabelRow(context),
                        ...daysOfMonth.map((week) {
                          return _buildWeek(context, week, dayDataByDay);
                        }),
                      ],
                    ),
                  ),
                );
              });
        });
  }

  Widget _buildMonthAndYear(
      final BuildContext context, final DateTime focusDate) {
    final ThemeData themeData = Theme.of(context);
    final String monthAndYear = DateTimeUtil.getMonthAndYear(focusDate);
    return Text(
      monthAndYear,
      style: themeData.textTheme.headline5?.copyWith(
          color: themeData.colorScheme.primaryContainer,
          fontWeight: FontWeight.w600,
          fontSize: 26),
    );
  }

  Widget _buildChangeMonthButton(
      final BuildContext context, final String direction, final onTap) {
    final ThemeData themeData = Theme.of(context);
    final iconData =
        direction == 'history' ? Icons.chevron_left : Icons.chevron_right;
    return Material(
      borderRadius: BorderRadius.circular(45.0),
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: InkWell(
          splashColor: themeData.colorScheme.primary,
          borderRadius: BorderRadius.circular(45.0),
          child: Icon(
            iconData,
            color: themeData.colorScheme.primaryContainer,
            size: 45,
          ),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _buildMonthSelection(
      final BuildContext context, final DateTime focusDate) {
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    final DateTime previousMonth = DateTimeUtil.previousMonthStart(focusDate);
    final DateTime nextMonth = DateTimeUtil.nextMonthStart(focusDate);
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildChangeMonthButton(context, 'history',
              () => dataBloc.changeFocusDate(previousMonth)),
          _buildMonthAndYear(context, focusDate),
          _buildChangeMonthButton(
              context, 'future', () => dataBloc.changeFocusDate(nextMonth)),
        ],
      ),
    );
  }

  Widget _buildCumulatedValue(final BuildContext context,
      final Evaluation evaluation, final int value) {
    final ThemeData themeData = Theme.of(context);
    final IconData iconData = Evaluations.getIcon(evaluation);
    final Color color = Evaluations.getColor(evaluation, themeData);
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 5.0),
            child: Icon(
              iconData,
              color: color,
              size: 42,
            ),
          ),
          Text(
            '$value',
            style: themeData.textTheme.headline6?.copyWith(
                color: color, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics(final BuildContext context) {
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    return Container(
      margin: const EdgeInsets.only(top: 30.0),
      child: StreamBuilder<BuiltMap<int, DayData>>(
          stream: dataBloc.monthsData,
          builder: (final BuildContext context,
              AsyncSnapshot<BuiltMap<int, DayData>> snapshot) {
            final BuiltMap<int, DayData> monthsData = snapshot.hasData
                ? snapshot.data!
                : BuiltMap.from(<int, DayData>{});
            final Statistics statistics =
                DayDataOperations.calculateStatistics(monthsData);

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCumulatedValue(
                    context, Evaluation.satisfied, statistics.satisfiedCount),
                _buildCumulatedValue(context, Evaluation.dissatisfied,
                    statistics.dissatisfiedCount),
                _buildCumulatedValue(
                    context, Evaluation.didLearn, statistics.didLearnNewCount),
              ],
            );
          }),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    return SafeArea(
      child: Scaffold(
          appBar: const CustomAppBar(),
          body: StreamBuilder<DateTime>(
              stream: dataBloc.focusDate,
              builder: (final BuildContext context,
                  AsyncSnapshot<DateTime> snapshot) {
                final DateTime focusDate =
                    snapshot.hasData ? snapshot.data! : DateTime.now();
                return Center(
                  child: Column(
                    children: [
                      _buildMonthSelection(context, focusDate),
                      _buildCalendar(context),
                      _buildStatistics(context),
                    ],
                  ),
                );
              })),
    );
  }
}
