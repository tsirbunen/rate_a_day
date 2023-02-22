import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'en.dart';
import 'fi.dart';
import 'phrase.dart';

class CustomLocalizations {
  final Locale locale;
  late Map<String, String> kaa;
  late Map<Phrase, String> dictionary;
  CustomLocalizations(this.locale) {
    if (locale.languageCode == 'fi') {
      dictionary = dictionaryFI;
    } else {
      dictionary = dictionaryEN;
    }
    //
    kaa = {'g': 'dfsfdsfdsfsfds'};
    print('setting ${locale.languageCode} !!!!!!');
  }

  static CustomLocalizations of(final BuildContext context) {
    return Localizations.of<CustomLocalizations>(context, CustomLocalizations)!;
  }

  static const LocalizationsDelegate<CustomLocalizations> delegate =
      CustomLocalizationsDelegate();

  Future<bool> load() async {
    // Miten tänne otetaan intl?
    return true;
  }

  String translate(final Phrase phrase) {
    // miten täällä otetaan intl:istä?
    // return 'KÄÄNNÖS ${kaa["g"]}';
    if (dictionary.containsKey(phrase)) return dictionary[phrase]!;
    return 'EI ole!!!';
  }

  static Iterable<Locale> get supportedLocales => [Locale('en'), Locale('fi')];
}

class CustomLocalizationsDelegate
    extends LocalizationsDelegate<CustomLocalizations> {
  const CustomLocalizationsDelegate();

  @override
  bool isSupported(final Locale locale) {
    // return ['en', 'fi'].contains(locale.languageCode);
    return CustomLocalizations.supportedLocales.contains(locale);
  }

  // @override
  // Future<CustomLocalizations> load(final Locale locale) async {
  //   final CustomLocalizations localizations = CustomLocalizations(locale);
  //   await localizations.load();
  //   return localizations;
  // }
  @override
  Future<CustomLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    print('reloading $locale');
    return SynchronousFuture<CustomLocalizations>(CustomLocalizations(locale));
  }

  @override
  bool shouldReload(CustomLocalizationsDelegate old) {
    print('checking in CustomLocalizationsDelegate if should reload');
    // return false;
    return true;
  }
}

// extension LocalizedBuildContext on BuildContext {
//   CustomLocalizations get loc => CustomLocalizations.of(this);
// }

extension LocalizedBuildContext on BuildContext {
  String translate(final Phrase phrase) =>
      CustomLocalizations.of(this).translate(phrase);
}
