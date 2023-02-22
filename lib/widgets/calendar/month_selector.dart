import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/utils.dart';

enum Mode { history, future }

class MonthSelector extends StatelessWidget {
  final DateTime focusDate;
  const MonthSelector({Key? key, required this.focusDate}) : super(key: key);

  Widget _buildMonthAndYear(
      final BuildContext context, final DateTime focusDate) {
    // final SettingsBloc settings = BlocProvider.of<SettingsBloc>(context);
    final ThemeData themeData = Theme.of(context);
    final Locale currentLocale = Localizations.localeOf(context);
    final String monthAndYear =
        DateTimeUtil.getMonthAndYear(focusDate, currentLocale);
    return Text(
      monthAndYear,
      style: themeData.textTheme.headline5?.copyWith(
          color: themeData.colorScheme.primary,
          fontWeight: FontWeight.w600,
          fontSize: 26),
    );
  }

  Widget _buildChangeMonth(
      final BuildContext context, final Mode mode, final DateTime targetDate) {
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    final ThemeData themeData = Theme.of(context);
    final iconData =
        mode == Mode.history ? Icons.chevron_left : Icons.chevron_right;
    return Material(
      borderRadius: BorderRadius.circular(45.0),
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: InkWell(
          splashColor: themeData.colorScheme.primary,
          borderRadius: BorderRadius.circular(45.0),
          child: Icon(
            iconData,
            color: themeData.colorScheme.primary,
            size: 45,
          ),
          onTap: () => dataBloc.changeFocusDate(targetDate),
        ),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final DateTime previousMonth = DateTimeUtil.previousMonthStart(focusDate);
    final DateTime nextMonth = DateTimeUtil.nextMonthStart(focusDate);

    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      width: ScreenSizeUtil.getCalendarWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildChangeMonth(context, Mode.history, previousMonth),
          _buildMonthAndYear(context, focusDate),
          _buildChangeMonth(context, Mode.future, nextMonth),
        ],
      ),
    );
  }
}
