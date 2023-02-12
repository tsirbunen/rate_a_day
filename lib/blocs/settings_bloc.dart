import 'dart:async';
import 'package:rate_a_day/packages/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc implements BlocBase {
  final String _languagePrefsKey = 'languagePrefsKey';
  final String _hideExtraInfoPrefsKey = 'hideExtraInfoPrefsKey';

  final Translator translator = Translator(Language.EN);

  final BehaviorSubject<Language> _language =
      BehaviorSubject<Language>.seeded(Language.EN);
  final BehaviorSubject<bool> _hideExtraInfo =
      BehaviorSubject<bool>.seeded(false);

  ValueStream<Language> get language => _language.stream;
  ValueStream<bool> get hideExtraInfo => _hideExtraInfo.stream;

  List<StreamSubscription> listeners = <StreamSubscription>[];

  SettingsBloc() {
    listeners.addAll([
      _language.listen(
          (final Language language) => _handleLanguageChanged(language)),
      _hideExtraInfo.listen(
          (final bool hideOrNot) => _handleHideExtraInfoChanged(hideOrNot)),
    ]);

    _initBloc();
  }

  Future<void> _initBloc() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? language = prefs.getString(_languagePrefsKey);
    if (language != null && language == Language.FI.toString()) {
      _language.add(Language.FI);
    }

    final bool? hideOrNot = prefs.getBool(_hideExtraInfoPrefsKey);
    if (hideOrNot != null) _hideExtraInfo.add(hideOrNot);
  }

  Future<void> _handleLanguageChanged(final Language language) async {
    translator.setDictionary(language);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_languagePrefsKey, language.toString());
  }

  Future<void> _handleHideExtraInfoChanged(final bool hideOrNot) async {
    if (_hideExtraInfo.hasValue && _hideExtraInfo.value == hideOrNot) return;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_hideExtraInfoPrefsKey, hideOrNot);
  }

  String translate(final Phrase phrase) {
    return translator.get(phrase);
  }

  void changeLanguage(final Language? language) {
    if (language == null) return;
    _language.add(language);
  }

  void hideInfo(final bool? hideOrNot) {
    if (hideOrNot == null) return;
    _hideExtraInfo.add(hideOrNot);
  }

  @override
  void dispose() {
    _language.close();
    _hideExtraInfo.close();

    for (var element in listeners) {
      element.cancel();
    }
  }
}
