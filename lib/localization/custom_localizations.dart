import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'en.dart';
import 'fi.dart';
import 'phrase.dart';

class CustomLocalizations {
  final Locale locale;
  late Map<Phrase, String> dictionary;

  CustomLocalizations(this.locale) {
    if (locale.languageCode == 'fi') {
      dictionary = dictionaryFI;
    } else {
      dictionary = dictionaryEN;
    }
  }

  static CustomLocalizations of(final BuildContext context) {
    return Localizations.of<CustomLocalizations>(context, CustomLocalizations)!;
  }

  static const LocalizationsDelegate<CustomLocalizations> delegate =
      CustomLocalizationsDelegate();

  String translate(final Phrase phrase) {
    if (dictionary.containsKey(phrase)) return dictionary[phrase]!;
    return '';
  }

  static Iterable<Locale> get supportedLocales =>
      [const Locale('en'), const Locale('fi')];
}

class CustomLocalizationsDelegate
    extends LocalizationsDelegate<CustomLocalizations> {
  const CustomLocalizationsDelegate();

  @override
  bool isSupported(final Locale locale) {
    return CustomLocalizations.supportedLocales.contains(locale);
  }

  @override
  Future<CustomLocalizations> load(Locale locale) {
    return SynchronousFuture<CustomLocalizations>(CustomLocalizations(locale));
  }

  @override
  bool shouldReload(CustomLocalizationsDelegate old) {
    return true;
  }
}

extension LocalizedBuildContext on BuildContext {
  String translate(final Phrase phrase) =>
      CustomLocalizations.of(this).translate(phrase);
}

translatePhrase(final Phrase phrase, final Locale locale) {
  if (locale.languageCode == 'fi') {
    return dictionaryFI[phrase];
  }
  return dictionaryEN[phrase];
}
