import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rate_a_day/packages/utils.dart';

class Today extends StatelessWidget {
  static const routeName = '/today';

  const Today({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    final String title = settingsBloc.translate(Phrase.todayTitle);
    final String subtitle = settingsBloc.translate(Phrase.todaySubtitle);
    final String happyOrNot = settingsBloc.translate(Phrase.howWasYourDay);
    final String didLearnNew = settingsBloc.translate(Phrase.didYouLearnNew);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Center(
            child: Container(
          color: themeData.colorScheme.background,
          child: Column(
            children: [
              PageTitle(title: title),
              PageSubtitle(subtitle: subtitle),
              const DateOfDayButton(),
              ParagraphTitle(title: happyOrNot),
              const HappyOrNotSelection(),
              ParagraphTitle(title: didLearnNew),
              const DidLearnToggle(),
              const SaveButton(),
            ],
          ),
        )),
      ),
    );
  }
}
