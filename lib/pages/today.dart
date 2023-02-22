import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rate_a_day/packages/utils.dart';
import '../localization/custom_localizations.dart';
import 'package:rate_a_day/packages/localizations.dart';

class Today extends StatelessWidget {
  static const routeName = '/today';

  const Today({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    // final SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    // final String title = settingsBloc.translate(Phrase.todayTitle);
    // final String subtitle = settingsBloc.translate(Phrase.todaySubtitle);
    // final String happyOrNot = settingsBloc.translate(Phrase.howWasYourDay);
    // final String didLearnNew = settingsBloc.translate(Phrase.didYouLearnNew);
    final String title = context.translate(Phrase.todayTitle);
    final String subtitle = context.translate(Phrase.todaySubtitle);
    final String happyOrNot = context.translate(Phrase.howWasYourDay);
    final String didLearnNew = context.translate(Phrase.didYouLearnNew);

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
              // Text(
              //   // 'test ${context.loc.translate("JEEEEE")}',
              //   'test ${context.translate("JEEEEE")} jeee',
              //   style: TextStyle(color: Colors.pink[300]),
              // ),
              Text(
                // 'test ${context.loc.translate("JEEEEE")}',
                'test ${context.translate(Phrase.howWasYourDay)} jeee',
                style: TextStyle(color: Colors.pink[300]),
              )
            ],
          ),
        )),
      ),
    );
  }
}
