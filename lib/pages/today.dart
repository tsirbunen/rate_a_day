import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rate_a_day/packages/localizations.dart';

class Today extends StatelessWidget {
  static const routeName = '/today';

  const Today({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final String title = context.translate(Phrase.todayTitle);
    final String subtitle = context.translate(Phrase.todaySubtitle);
    final String happyOrNot = context.translate(Phrase.howWasYourDay);
    final String didLearnNew = context.translate(Phrase.didYouLearnNew);

    return PageScaffold(
      child: Column(
        children: [
          PageTitle(title: title),
          PageSubtitle(subtitle: subtitle),
          DateOfDayButton(),
          ParagraphTitle(title: happyOrNot),
          HappyOrNotSelection(),
          ParagraphTitle(title: didLearnNew),
          const DidLearnToggle(),
          SaveButton(),
        ],
      ),
    );
  }
}
