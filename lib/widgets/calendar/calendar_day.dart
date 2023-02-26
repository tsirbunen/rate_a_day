import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/localizations.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/pages.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/main.dart';
import 'package:rate_a_day/packages/widgets.dart';

class CalendarDay extends StatelessWidget {
  final int day;
  final DayData? dayData;

  const CalendarDay({Key? key, required this.day, this.dayData})
      : super(key: key);

  void _handleTappedDay(
      final DateTime newFocusDate, final Function changeFocusDate) {
    final NavigatorState? navigatorState = navigatorKey.currentState;
    if (navigatorState == null) return;
    changeFocusDate(newFocusDate);
    navigatorState.pushReplacementNamed(Today.routeName);
  }

  Color _getIconColor(final ThemeData themeData, final bool noRating) {
    if (noRating) {
      return Evaluations.getColor(Evaluation.noEvaluation, themeData);
    }
    return dayData == null
        ? Colors.transparent
        : dayData!.rating == Rating.HAPPY
            ? Evaluations.getColor(Evaluation.satisfied, themeData)
            : Evaluations.getColor(Evaluation.dissatisfied, themeData);
  }

  IconData _getIconData() {
    Evaluation evaluation;
    if (dayData == null || dayData!.rating == Rating.MISSING) {
      evaluation = Evaluation.noEvaluation;
    } else if (dayData!.rating == Rating.UNHAPPY) {
      evaluation = Evaluation.dissatisfied;
    } else {
      evaluation = Evaluation.satisfied;
    }
    return Evaluations.getIcon(evaluation);
  }

  Widget _getRatingIcon(
      final ThemeData themeData, final bool noRating, final double dayWidth) {
    return Icon(
      _getIconData(),
      color: _getIconColor(themeData, noRating),
      size: dayWidth + 2,
    );
  }

  Widget _buildDayNumber(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final bool didLearnNew = dayData != null ? dayData!.didLearnNew : false;
    final TextStyle style = didLearnNew
        ? StyleUtil.didLearnDayText(themeData)
        : StyleUtil.didNotLearnDayText(themeData);

    return Transform.scale(
      scaleX: 1.3,
      child: Text(day.toString(), style: style),
    );
  }

  Widget _buildDayIcon(final BuildContext context, final ThemeData themeData,
      final void Function() onTap, final double dayWidth) {
    final bool noRating = dayData == null || dayData!.rating == Rating.MISSING;
    Widget ratingIcon = _getRatingIcon(themeData, noRating, dayWidth);
    final double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final double marginTop = textScaleFactor > 1 ? 20.0 : 15;
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          child: InkWell(
            borderRadius: BorderRadius.circular(100.0),
            onTap: onTap,
            child: ratingIcon,
          ),
        ),
      ),
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

  @override
  Widget build(final BuildContext context) {
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    final ThemeData themeData = Theme.of(context);
    final double calendarWidth = SizeUtil.getCalendarWidth(context);
    final double dayWidth = calendarWidth / 7.0;

    return StreamBuilder<DateTime>(
      stream: dataBloc.focusDate,
      builder: (final BuildContext context, AsyncSnapshot<DateTime> snapshot) {
        final DateTime focusDate =
            snapshot.hasData ? snapshot.data! : DateTime.now();
        final DateTime newFocusDate =
            DateTime(focusDate.year, focusDate.month, day);
        final bool isDisabled = (newFocusDate.compareTo(DateTime.now()) > 0);
        final void Function() onTap = isDisabled
            ? () => _showSnackbar(context, Phrase.cannotRateFuture)
            : () => _handleTappedDay(newFocusDate, dataBloc.changeFocusDate);

        return SizedBox(
          width: dayWidth,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              _buildDayNumber(context),
              _buildDayIcon(context, themeData, onTap, dayWidth),
            ],
          ),
        );
      },
    );
  }
}
