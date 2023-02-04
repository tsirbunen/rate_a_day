import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc implements BlocBase {
  final String languagePrefsKey = 'languagePrefsKey';
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
    final String? language = prefs.getString(languagePrefsKey);
    if (language == null) return;
    if (language == Language.FI.toString()) {
      _language.add(Language.FI);
    }
  }

  Future<void> _handleLanguageChanged(final Language language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(languagePrefsKey, language.toString());
  }

  @override
  void dispose() {
    _language.close();

    for (var element in listeners) {
      element.cancel();
    }
  }
}
