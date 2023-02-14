import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/widgets.dart';

class Settings extends StatelessWidget {
  static const routeName = '/settings';

  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    final ThemeData themeData = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Container(
          color: themeData.colorScheme.background,
          width: ScreenSizeUtil.getFullWidth(context),
          child: StreamBuilder<Language>(
            stream: settingsBloc.language,
            builder: (final BuildContext context,
                final AsyncSnapshot<Language> languageSnapshot) {
              final Language currentLanguage = languageSnapshot.hasData
                  ? languageSnapshot.data!
                  : Language.EN;
              final Translator translator = Translator(currentLanguage);
              final String title = translator.get(Phrase.settingsTitle);
              return Container(
                margin: const EdgeInsets.only(left: 20.0, top: 20.0),
                child: Column(
                  children: [
                    PageTitle(title: title),
                    SelectLanguage(currentLanguage: currentLanguage),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
