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
      final BuildContext context, final bool currentHide) {
    final SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    final Map<Language, String> data = {
      Language.EN: settingsBloc.translate(Phrase.english),
      Language.FI: settingsBloc.translate(Phrase.finnish),
    };

    return StreamBuilder<Language>(
      stream: settingsBloc.language,
      builder: (final BuildContext context, AsyncSnapshot<Language> snapshot) {
        final Language currentLanguage =
            snapshot.hasData ? snapshot.data! : Language.EN;
        return Container(
          margin: const EdgeInsets.only(bottom: 20.0, top: 20.0),
          child: RadioSelector<Language>(
            data: data,
            onSelected: settingsBloc.changeLanguage,
            title: settingsBloc.translate(Phrase.language),
            info: currentHide
                ? null
                : settingsBloc.translate(Phrase.languageInfo),
            currentValue: currentLanguage,
          ),
        );
      },
    );
  }

  Widget _buildHideInfoSelector(
      final BuildContext context, final bool currentHide) {
    final SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    final Map<bool, String> data = {
      false: settingsBloc.translate(Phrase.doNotHideInfo),
      true: settingsBloc.translate(Phrase.hideInfo),
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 20.0, top: 20.0),
      child: RadioSelector<bool>(
        data: data,
        onSelected: settingsBloc.hideInfo,
        title: settingsBloc.translate(Phrase.hideOrNot),
        info: currentHide ? null : settingsBloc.translate(Phrase.hideOrNotInfo),
        currentValue: currentHide,
      ),
    );
    //   },
    // );
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
                (final BuildContext context, AsyncSnapshot<bool> snapshot) {
              final bool currentHide =
                  snapshot.hasData ? snapshot.data! : false;
              return Container(
                margin: const EdgeInsets.only(left: 20.0, top: 20.0),
                child: Column(
                  children: [
                    _buildLanguageSelector(context, currentHide),
                    _buildHideInfoSelector(context, currentHide),
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
