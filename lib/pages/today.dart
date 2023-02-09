import 'package:flutter/material.dart';
import 'package:rate_a_day/main.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/pages/calendar.dart';

class Today extends StatelessWidget {
  static const routeName = '/today';
  final double iconSize = 80.0;

  const Today({Key? key}) : super(key: key);

  Widget _buildDateOfTheDay(final BuildContext context) {
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
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
          final String mainText = focusIsToday ? 'Today' : date;
          final String minorText =
              focusIsToday ? date : DateTimeUtil.getWeekday(focusDate);

          return Column(
            children: [
              Text(minorText,
                  style: themeData.textTheme.headline2
                      ?.copyWith(color: themeData.colorScheme.secondary)),
              Text(mainText,
                  style: themeData.textTheme.headline1
                      ?.copyWith(color: themeData.colorScheme.secondary)),
            ],
          );
        });
  }

  Widget _buildPhrase(final BuildContext context, final String text) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 30.0),
      child: Text(text,
          style: themeData.textTheme.headline5
              ?.copyWith(color: themeData.colorScheme.secondary)),
    );
  }

  Widget _buildFace(final BuildContext context, final Rating type,
      final Rating assessment, onAssessed) {
    final ThemeData themeData = Theme.of(context);
    final IconData iconData = type == Rating.HAPPY
        ? Evaluations.getIcon(Evaluation.satisfied)
        : Evaluations.getIcon(Evaluation.dissatisfied);
    Color color;
    if (assessment == Rating.UNHAPPY && type == Rating.UNHAPPY) {
      color = Evaluations.getColor(Evaluation.dissatisfied, themeData);
    } else if (assessment == Rating.HAPPY && type == Rating.HAPPY) {
      color = Evaluations.getColor(Evaluation.satisfied, themeData);
    } else {
      color = Evaluations.getColor(Evaluation.didNotLearn, themeData);
    }

    return Material(
      borderRadius: BorderRadius.circular(iconSize),
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: InkWell(
          splashColor: themeData.colorScheme.primary,
          borderRadius: BorderRadius.circular(iconSize),
          child: Icon(
            iconData,
            color: color,
            size: iconSize,
          ),
          onTap: () => onAssessed(type),
        ),
      ),
    );
  }

  Widget _buildFaces(final BuildContext context) {
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: StreamBuilder<Rating>(
          stream: dataBloc.rating,
          builder:
              (final BuildContext context, AsyncSnapshot<Rating> snapshot) {
            final Rating assessment =
                snapshot.hasData ? snapshot.data! : Rating.MISSING;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildFace(context, Rating.UNHAPPY, assessment, dataBloc.rate),
                _buildFace(context, Rating.HAPPY, assessment, dataBloc.rate),
              ],
            );
          }),
    );
  }

  Widget _buildRocket(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    return StreamBuilder<bool>(
        stream: dataBloc.didLearnNew,
        builder: (final BuildContext context, AsyncSnapshot<bool> snapshot) {
          final bool didLearn = snapshot.hasData ? snapshot.data! : false;
          final Color color = didLearn
              ? Evaluations.getColor(Evaluation.didLearn, themeData)
              : Evaluations.getColor(Evaluation.didNotLearn, themeData);
          return Container(
              margin: const EdgeInsets.only(top: 20),
              child: Material(
                borderRadius: BorderRadius.circular(iconSize),
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  child: InkWell(
                    splashColor: themeData.colorScheme.primary,
                    borderRadius: BorderRadius.circular(iconSize),
                    child: Icon(
                      didLearn
                          ? Evaluations.getIcon(Evaluation.didLearn)
                          : Evaluations.getIcon(Evaluation.didNotLearn),
                      color: color,
                      size: iconSize,
                    ),
                    onTap: () => dataBloc.toggleLearned(!didLearn),
                  ),
                ),
              ));
        });
  }

  void _navigateToCalendarPage() {
    final NavigatorState? navigatorState = navigatorKey.currentState;
    if (navigatorState == null) return;
    navigatorState.pushNamed(Calendar.routeName);
  }

  Widget _buildSaveButton(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    return Container(
      margin: const EdgeInsets.only(top: 40.0),
      child: StreamBuilder<Status>(
          stream: dataBloc.status,
          builder:
              (final BuildContext context, AsyncSnapshot<Status> snapshot) {
            final Status? status = snapshot.hasData ? snapshot.data : null;

            if (status != Status.READY) {
              return SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  color: themeData.colorScheme.secondary,
                  backgroundColor: themeData.colorScheme.primaryContainer,
                  strokeWidth: 10.0,
                ),
              );
            }

            return ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('SAVE',
                    style: themeData.textTheme.headline5
                        ?.copyWith(color: themeData.colorScheme.secondary)),
              ),
              onPressed: () async {
                final bool? success = await dataBloc.saveData();
                if (success == true) _navigateToCalendarPage();
              },
            );
          }),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: const CustomAppBar(),
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 80.0),
                child: Column(
                  children: [
                    // TODO: Add possibility to change the date also from this page.
                    _buildDateOfTheDay(context),
                    // TODO: Use translations AND change the phrase according to the date
                    // being today or earlier in history.
                    _buildPhrase(context, 'How has your day been?'),
                    _buildFaces(context),
                    _buildPhrase(context, 'Learned anything new?'),
                    _buildRocket(context),
                    _buildSaveButton(context),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
