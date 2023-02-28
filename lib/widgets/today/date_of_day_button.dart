import 'package:flutter/material.dart';
import 'package:rate_a_day/main.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/pages.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/localizations.dart';

class DateOfDayButton extends StatelessWidget with Constants {
  DateOfDayButton({Key? key}) : super(key: key);

  void _handleTappedDate() {
    final NavigatorState? navigatorState = navigatorKey.currentState;
    if (navigatorState == null) return;
    navigatorState.pushReplacementNamed(Month.routeName);
  }

  @override
  Widget build(final BuildContext context) {
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    final ThemeData themeData = Theme.of(context);
    final Locale currentLocale = Localizations.localeOf(context);
    final TextStyle mainStyle = StyleUtil.dateOfDayMainText(themeData);
    final TextStyle minorStyle = StyleUtil.dateOfDayMinorText(themeData);
    final Color backgroundColor = StyleUtil.dateOfDayBackground(themeData);
    final double buttonBorderRadius = SizeUtil.borderRadius;

    return StreamBuilder<DateTime>(
      stream: dataBloc.focusDate,
      builder: (final BuildContext context, AsyncSnapshot<DateTime> snapshot) {
        final DateTime focusDate =
            snapshot.hasData ? snapshot.data! : DateTime.now();
        final DateTime today = DateTime.now();
        final bool focusIsToday = DateTimeUtil.areSameDate(focusDate, today);
        final String date = DateTimeUtil.getDate(focusDate);
        final String mainText =
            focusIsToday ? context.translate(Phrase.today).toUpperCase() : date;
        final String minorText = focusIsToday
            ? date
            : DateTimeUtil.getWeekday(focusDate.weekday, currentLocale);

        return GestureDetector(
          onTap: _handleTappedDate,
          child: Container(
            padding: EdgeInsets.only(
                left: paddingS,
                right: paddingS,
                top: paddingXS,
                bottom: paddingXS),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(buttonBorderRadius),
            ),
            child: Column(
              children: [
                Text(minorText, style: minorStyle),
                Text(mainText, style: mainStyle),
              ],
            ),
          ),
        );
      },
    );
  }
}
