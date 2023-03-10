import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/localizations.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/widgets.dart';

enum Mode { history, future }

class MonthSelector extends StatelessWidget with Constants {
  final DateTime focusDate;

  MonthSelector({Key? key, required this.focusDate}) : super(key: key);

  Widget _buildMonthAndYear(
      final BuildContext context, final DateTime focusDate) {
    final ThemeData themeData = Theme.of(context);
    final Locale currentLocale = Localizations.localeOf(context);
    final textScaleFactor = MediaQuery.maybeOf(context)?.textScaleFactor ?? 1.0;
    final bool shortMonthName = textScaleFactor > 1.0;
    final String monthAndYear =
        DateTimeUtil.getMonthAndYear(focusDate, currentLocale, shortMonthName);
    final TextStyle style = StyleUtil.monthAndYear(themeData);

    return Text(
      monthAndYear,
      style: style,
    );
  }

  void _showSnackbar(final BuildContext context, final Phrase phrase) {
    snackbarKey.currentState?.showSnackBar(CustomSnackbar.buildSnackbar(
      title: 'ERROR',
      message: context.translate(phrase),
      action: () => {},
      isError: true,
    ));
  }

  Widget _buildChangeMonth(
      final BuildContext context, final Mode mode, final DateTime targetDate) {
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    final ThemeData themeData = Theme.of(context);
    final iconData =
        mode == Mode.history ? Icons.chevron_left : Icons.chevron_right;
    final bool isFutureMonth = DateTimeUtil.isFutureMonth(targetDate);
    final double size = SizeUtil.changeMonthArrowIcon;
    final Color arrowColor = StyleUtil.changeMonthArrow(themeData);

    return Material(
      borderRadius: BorderRadius.circular(size),
      color: Colors.transparent,
      child: InkWell(
        splashColor: arrowColor,
        borderRadius: BorderRadius.circular(size),
        child: Icon(
          iconData,
          color: arrowColor,
          size: size,
        ),
        onTap: isFutureMonth
            ? () => _showSnackbar(context, Phrase.cannotRateFuture)
            : () => dataBloc.changeFocusDate(targetDate),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final DateTime previousMonth = DateTimeUtil.previousMonthStart(focusDate);
    final DateTime nextMonth = DateTimeUtil.nextMonthStart(focusDate);

    return Container(
      margin: EdgeInsets.only(bottom: paddingS),
      width: SizeUtil.getCalendarWidth(context),
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
