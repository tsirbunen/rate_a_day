import 'package:flutter/material.dart';
import 'package:rate_a_day/main.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/pages.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rate_a_day/packages/utils.dart';

class Today extends StatelessWidget {
  static const routeName = '/today';

  const Today({Key? key}) : super(key: key);

  void _navigateToCalendarPage() {
    final NavigatorState? navigatorState = navigatorKey.currentState;
    if (navigatorState == null) return;
    navigatorState.pushReplacementNamed(Calendar.routeName);
  }

  Widget _buildSaveButton(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    final SettingsBloc settings = BlocProvider.of<SettingsBloc>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40.0),
      child: StreamBuilder<Status>(
          stream: dataBloc.status,
          builder:
              (final BuildContext context, AsyncSnapshot<Status> snapshot) {
            final Status? status = snapshot.hasData ? snapshot.data : null;

            if (status != Status.DIRTY) return Column();

            return ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(settings.translate(Phrase.saveData).toUpperCase(),
                    style: themeData.textTheme.headline5?.copyWith(
                        color: themeData.colorScheme.onSecondaryContainer)),
              ),
              onPressed: () async {
                final bool? success = await dataBloc.saveData();
                if (success == true) _navigateToCalendarPage();
              },
            );
          }),
    );
  }

  Widget _buildChangeDateInfo(final BuildContext context) {
    final SettingsBloc settings = BlocProvider.of<SettingsBloc>(context);

    return TextInfo(
      primary: null,
      secondary: settings.translate(Phrase.changeDateInfo),
    );
  }

  Widget _buildHappyOrNotInfo(
      final BuildContext context, final bool isInHistory, final bool hideInfo) {
    final SettingsBloc settings = BlocProvider.of<SettingsBloc>(context);
    final Phrase primaryText =
        isInHistory ? Phrase.howWasYourDay : Phrase.howHasDayBeen;
    final Phrase secondaryText =
        isInHistory ? Phrase.wasHappyOrNot : Phrase.beenHappyOrNot;

    return TextInfo(
      primary: settings.translate(primaryText),
      secondary: hideInfo ? null : settings.translate(secondaryText),
    );
  }

  Widget _buildDidLearnNewInfo(
      final BuildContext context, final bool isInHistory, final bool hideInfo) {
    final SettingsBloc settings = BlocProvider.of<SettingsBloc>(context);
    final Phrase primaryText =
        isInHistory ? Phrase.didYouLearnNew : Phrase.haveYouLearnedNew;
    final Phrase secondaryText =
        isInHistory ? Phrase.didOrDidNotLearn : Phrase.haveOrNotLearned;

    return TextInfo(
      primary: settings.translate(primaryText),
      secondary: hideInfo ? null : settings.translate(secondaryText),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    final SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Center(
          child: StreamBuilder<DateTime>(
              stream: dataBloc.focusDate,
              builder: (final BuildContext context,
                  AsyncSnapshot<DateTime> dateSnapshot) {
                final DateTime focusDate =
                    dateSnapshot.hasData ? dateSnapshot.data! : DateTime.now();
                final bool isInHistory = DateTimeUtil.isHistoryDate(focusDate);

                return StreamBuilder<bool>(
                    stream: settingsBloc.hideExtraInfo,
                    builder: (final BuildContext context,
                        AsyncSnapshot<bool> hideSnapshot) {
                      final bool hideInfo =
                          hideSnapshot.hasData ? hideSnapshot.data! : false;
                      return Container(
                        padding: const EdgeInsets.only(top: 30.0),
                        color: themeData.colorScheme.background,
                        child: Column(
                          children: [
                            const DateOfDay(),
                            if (!hideInfo) _buildChangeDateInfo(context),
                            _buildHappyOrNotInfo(
                                context, isInHistory, hideInfo),
                            const HappyOrNotSelection(),
                            _buildDidLearnNewInfo(
                                context, isInHistory, hideInfo),
                            const DidLearnToggle(),
                            _buildSaveButton(context),
                          ],
                        ),
                      );
                    });
              }),
        ),
      ),
    );
  }
}
