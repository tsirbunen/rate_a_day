import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rate_a_day/widgets/calendar_month.dart';

class Calendar extends StatelessWidget {
  static const routeName = '/calendar';

  const Calendar({Key? key}) : super(key: key);

  Widget _buildStatistics(final BuildContext context) {
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
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
                Cumulated(
                    evaluation: Evaluation.satisfied,
                    value: statistics.satisfiedCount),
                Cumulated(
                    evaluation: Evaluation.dissatisfied,
                    value: statistics.dissatisfiedCount),
                Cumulated(
                    evaluation: Evaluation.didLearn,
                    value: statistics.didLearnNewCount),
              ],
            );
          }),
    );
  }

  BoxDecoration _getCalendarDecoration(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BoxDecoration(
      border:
          Border.all(width: 1.5, color: themeData.colorScheme.primaryContainer),
      borderRadius: BorderRadius.circular(6.0),
    );
  }

  Widget _buildCalendar(final BuildContext context) {
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);

    return Container(
      decoration: _getCalendarDecoration(context),
      padding:
          const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0, top: 5.0),
      child: StreamBuilder<DateTime>(
          stream: dataBloc.focusDate,
          builder:
              (final BuildContext context, AsyncSnapshot<DateTime> snapshot) {
            final DateTime focusDate =
                snapshot.hasData ? snapshot.data! : DateTime.now();
            return Column(
              children: [
                MonthSelector(focusDate: focusDate),
                CalendarMonth(focusDate: focusDate),
              ],
            );
          }),
    );
  }

  Widget _buildInfo(final BuildContext context) {
    final SettingsBloc settings = BlocProvider.of<SettingsBloc>(context);

    return TextInfo(
      primary: null,
      secondary: settings.translate(Phrase.calendarInfo),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Container(
          color: themeData.colorScheme.background,
          child: Center(
            child: StreamBuilder<bool>(
                stream: settingsBloc.hideExtraInfo,
                builder:
                    (final BuildContext context, AsyncSnapshot<bool> snapshot) {
                  final bool hideInfo =
                      snapshot.hasData ? snapshot.data! : false;
                  return Column(
                    children: [
                      const SizedBox(height: 30.0),
                      _buildCalendar(context),
                      const SizedBox(height: 10.0),
                      if (!hideInfo) _buildInfo(context),
                      _buildStatistics(context),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
