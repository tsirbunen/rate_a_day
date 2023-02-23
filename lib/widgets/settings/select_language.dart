import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rate_a_day/packages/localizations.dart';

class SelectLanguage extends StatelessWidget {
  const SelectLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    final current = Localizations.localeOf(context);

    final Map<Locale, String> data = {
      const Locale('en'): context.translate(Phrase.english),
      const Locale('fi'): context.translate(Phrase.finnish),
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 20.0, top: 20.0),
      child: RadioSelector<Locale>(
        data: data,
        onSelected: settingsBloc.changeLocale,
        title: context.translate(Phrase.language),
        info: context.translate(Phrase.languageInfo),
        currentValue: current,
      ),
    );
  }
}
