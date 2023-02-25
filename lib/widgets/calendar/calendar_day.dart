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
    if (noRating) return Colors.transparent;
    return dayData == null
        ? Colors.transparent
        : dayData!.rating == Rating.HAPPY
            ? Evaluations.getColor(Evaluation.satisfied, themeData)
            : Evaluations.getColor(Evaluation.dissatisfied, themeData);
  }

  Color _getNumberColor(final ThemeData themeData, final bool didLearnNew) =>
      didLearnNew
          ? themeData.colorScheme.onTertiary
          : themeData.colorScheme.primaryContainer;

  BoxDecoration? _getDecoration(
      final ThemeData themeData, final bool noRating) {
    if (!noRating) return null;

    return BoxDecoration(
      border:
          Border.all(color: themeData.colorScheme.primaryContainer, width: 2.0),
      shape: BoxShape.circle,
    );
  }

  IconData _getIconData(final bool noRating) {
    final Evaluation evaluation =
        dayData != null && dayData!.rating == Rating.UNHAPPY
            ? Evaluation.dissatisfied
            : Evaluation.satisfied;
    return Evaluations.getIcon(evaluation);
  }

  Widget _getRatingIcon(final ThemeData themeData, final bool noRating) {
    return Icon(
      _getIconData(noRating),
      color: _getIconColor(themeData, noRating),
      size: noRating ? 36.0 : 50.0,
    );
  }

  Widget _buildDayNumber(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final bool didLearnNew = dayData != null ? dayData!.didLearnNew : false;
    final Color dayNumberColor = _getNumberColor(themeData, didLearnNew);
    return Transform.scale(
      scaleX: 1.3,
      child: Text(day.toString(),
          style: themeData.textTheme.headline6
              ?.copyWith(color: dayNumberColor, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildDayIcon(final ThemeData themeData, final void Function() onTap) {
    final bool noRating = dayData == null || dayData!.rating == Rating.MISSING;
    Widget ratingIcon = _getRatingIcon(themeData, noRating);
    BoxDecoration? decoration = _getDecoration(themeData, noRating);
    return Container(
      margin: EdgeInsets.only(top: noRating ? 21.0 : 16.0),
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: decoration,
          child: InkWell(
            borderRadius: BorderRadius.circular(52.0),
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
          width: 60,
          height: 66,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              _buildDayNumber(context),
              _buildDayIcon(themeData, onTap),
            ],
          ),
        );
      },
    );
  }
}
