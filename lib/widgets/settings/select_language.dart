import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/widgets.dart';

class SelectLanguage extends StatelessWidget {
  final Language currentLanguage;
  const SelectLanguage({Key? key, required this.currentLanguage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    final Translator translator = Translator(currentLanguage);
    final Map<Language, String> data = {
      Language.EN: translator.get(Phrase.english),
      Language.FI: translator.get(Phrase.finnish),
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 20.0, top: 20.0),
      child: RadioSelector<Language>(
        data: data,
        onSelected: settingsBloc.changeLanguage,
        title: translator.get(Phrase.language),
        info: translator.get(Phrase.languageInfo),
        currentValue: currentLanguage,
      ),
    );
  }
}
