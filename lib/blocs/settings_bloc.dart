import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rate_a_day/packages/blocs.dart';

class SettingsBloc implements BlocBase {
  final String _localePrefsKey = 'localePrefs';

  final BehaviorSubject<Locale?> _locale =
      BehaviorSubject<Locale?>.seeded(null);

  ValueStream<Locale?> get locale => _locale.stream;

  List<StreamSubscription> listeners = <StreamSubscription>[];

  SettingsBloc() {
    listeners.addAll([
      _locale.listen((final Locale? l) => _handleLocaleChanged(l)),
    ]);

    _initBloc();
  }

  Future<void> _initBloc() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? localeCode = prefs.getString(_localePrefsKey);
    if (localeCode != null && localeCode != 'en') {
      _locale.add(Locale(localeCode));
    }
  }

  Future<void> _handleLocaleChanged(final Locale? newLocale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (newLocale == null) {
      prefs.remove(_localePrefsKey);
      return;
    }
    prefs.setString(_localePrefsKey, newLocale.languageCode);
  }

  void changeLocale(final Locale? l) {
    _locale.add(l);
  }

  @override
  void dispose() {
    _locale.close();

    for (var element in listeners) {
      element.cancel();
    }
  }
}
