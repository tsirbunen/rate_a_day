import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rate_a_day/packages/localizations.dart';

class SelectLanguage extends StatelessWidget {
  // final Language currentLanguage;
  // const SelectLanguage({Key? key, required this.currentLanguage})
  const SelectLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    final current = Localizations.localeOf(context);
    // final Translator translator = Translator(currentLanguage);
    final Map<Locale, String> data = {
      // Language.EN: translator.get(Phrase.english),
      // Language.FI: translator.get(Phrase.finnish),
      Locale('en'): context.translate(Phrase.english),
      Locale('fi'): context.translate(Phrase.finnish),
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 20.0, top: 20.0),
      child: RadioSelector<Locale>(
        data: data,
        // onSelected: settingsBloc.changeLanguage,
        // title: translator.get(Phrase.language),
        // info: translator.get(Phrase.languageInfo),
        // currentValue: currentLanguage,
        onSelected: settingsBloc.changeLocale,
        title: context.translate(Phrase.language),
        info: context.translate(Phrase.languageInfo),
        currentValue: current,
      ),
    );
  }
}
