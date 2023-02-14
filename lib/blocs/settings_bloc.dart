import 'dart:async';
import 'package:rate_a_day/packages/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc implements BlocBase {
  final String _languagePrefsKey = 'languagePrefsKey';

  final Translator translator = Translator(Language.EN);

  final BehaviorSubject<Language> _language =
      BehaviorSubject<Language>.seeded(Language.EN);

  ValueStream<Language> get language => _language.stream;

  List<StreamSubscription> listeners = <StreamSubscription>[];

  SettingsBloc() {
    listeners.addAll([
      _language.listen(
          (final Language language) => _handleLanguageChanged(language)),
    ]);

    _initBloc();
  }

  Future<void> _initBloc() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? language = prefs.getString(_languagePrefsKey);
    if (language != null && language == Language.FI.toString()) {
      _language.add(Language.FI);
    }
  }

  Future<void> _handleLanguageChanged(final Language language) async {
    translator.setDictionary(language);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_languagePrefsKey, language.toString());
  }

  String translate(final Phrase phrase) {
    return translator.get(phrase);
  }

  void changeLanguage(final Language? language) {
    if (language == null) return;
    _language.add(language);
  }

  @override
  void dispose() {
    _language.close();

    for (var element in listeners) {
      element.cancel();
    }
  }
}
