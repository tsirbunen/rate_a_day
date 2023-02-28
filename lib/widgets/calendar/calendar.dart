import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/widgets.dart';

class Calendar extends StatelessWidget with Constants {
  Calendar({Key? key}) : super(key: key);

  BoxDecoration _getCalendarDecoration(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Color borderColor = StyleUtil.calendarBorder(themeData);

    return BoxDecoration(
      border: Border.all(width: 1.5, color: borderColor),
      borderRadius: BorderRadius.circular(6.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);

    return Container(
      decoration: _getCalendarDecoration(context),
      padding: EdgeInsets.only(
        left: paddingS,
        right: paddingS,
        bottom: paddingXS,
        top: paddingXS,
      ),
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
        },
      ),
    );
  }
}
