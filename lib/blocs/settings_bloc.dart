import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rate_a_day/packages/localizations.dart';

class SettingsBloc implements BlocBase {
  final String _languagePrefsKey = 'languagePrefsKey';
  final String _localePrefsKey = 'localePrefs';

  // final Translator translator = Translator(Language.EN);

  // final BehaviorSubject<Language> _language =
  //     BehaviorSubject<Language>.seeded(Language.EN);

  final BehaviorSubject<Locale?> _locale =
      BehaviorSubject<Locale?>.seeded(null);

  // ValueStream<Language> get language => _language.stream;
  ValueStream<Locale?> get locale => _locale.stream;

  List<StreamSubscription> listeners = <StreamSubscription>[];

  SettingsBloc() {
    listeners.addAll([
      // _language.listen(
      //     (final Language language) => _handleLanguageChanged(language)),
      _locale.listen((final Locale? l) => _handleLocaleChanged(l)),
    ]);

    _initBloc();
  }

  Future<void> _initBloc() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // final String? language = prefs.getString(_languagePrefsKey);
    // if (language != null && language == Language.FI.toString()) {
    //   _language.add(Language.FI);
    // }
    final String? localeCode = prefs.getString(_localePrefsKey);
    if (localeCode != null && localeCode != 'en') {
      _locale.add(Locale(localeCode));
    }
  }

  // Future<void> _handleLanguageChanged(final Language language) async {
  //   translator.setDictionary(language);
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(_languagePrefsKey, language.toString());
  // }

  Future<void> _handleLocaleChanged(final Locale? l) async {
    // translator.setDictionary(language);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (l == null) {
      // poista
      return;
    }
    prefs.setString(_localePrefsKey, l.languageCode);
  }

  // String translate(final Phrase phrase) {
  //   return translator.get(phrase);
  // }

  // void changeLanguage(final Language? language) {
  //   if (language == null) return;
  //   _language.add(language);
  // }

  void changeLocale(final Locale? l) {
    // if (language == null) return;
    _locale.add(l);
  }

  @override
  void dispose() {
    // _language.close();
    _locale.close();

    for (var element in listeners) {
      element.cancel();
    }
  }
}
