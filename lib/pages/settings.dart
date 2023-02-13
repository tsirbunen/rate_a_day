import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rate_a_day/widgets/radio_selector.dart';

class Settings extends StatelessWidget {
  static const routeName = '/settings';

  const Settings({Key? key}) : super(key: key);

  Widget _buildLanguageSelector(
    final BuildContext context,
    final bool currentHide,
    final Language currentLanguage,
  ) {
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
        info: currentHide ? null : translator.get(Phrase.languageInfo),
        currentValue: currentLanguage,
      ),
    );
  }

  Widget _buildHideInfoSelector(
    final BuildContext context,
    final bool currentHide,
    final Language currentLanguage,
  ) {
    final SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    final Translator translator = Translator(currentLanguage);
    final Map<bool, String> data = {
      false: translator.get(Phrase.doNotHideInfo),
      true: translator.get(Phrase.hideInfo),
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 20.0, top: 20.0),
      child: RadioSelector<bool>(
        data: data,
        onSelected: settingsBloc.hideInfo,
        title: translator.get(Phrase.hideOrNot),
        info: currentHide ? null : translator.get(Phrase.hideOrNotInfo),
        currentValue: currentHide,
      ),
    );
  }

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
          child: StreamBuilder<bool>(
            stream: settingsBloc.hideExtraInfo,
            builder:
                (final BuildContext context, AsyncSnapshot<bool> hideSnapshot) {
              final bool currentHide =
                  hideSnapshot.hasData ? hideSnapshot.data! : false;
              return StreamBuilder<Language>(
                  stream: settingsBloc.language,
                  builder: (final BuildContext context,
                      final AsyncSnapshot<Language> languageSnapshot) {
                    final Language currentLanguage = languageSnapshot.hasData
                        ? languageSnapshot.data!
                        : Language.EN;
                    return Container(
                      margin: const EdgeInsets.only(left: 20.0, top: 20.0),
                      child: Column(
                        children: [
                          _buildLanguageSelector(
                              context, currentHide, currentLanguage),
                          _buildHideInfoSelector(
                              context, currentHide, currentLanguage),
                        ],
                      ),
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
}
