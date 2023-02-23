import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/localizations.dart';

void main() {
  group('Settings bloc', () {
    // test('Language can be updated', () {
    //   SharedPreferences.setMockInitialValues({});
    //   final SettingsBloc settings = SettingsBloc();
    //   final ValueStream<Language> stream = settings.language;
    //   settings.changeLanguage(Language.FI);
    //   expect(stream, emits(Language.FI));
    //   settings.changeLanguage(Language.EN);
    //   expect(stream, emits(Language.EN));
    // });

    // test('Language from shared preferences is used', () async {
    //   SharedPreferences.setMockInitialValues({'languagePrefsKey': 'FI'});
    //   final SettingsBloc settings = SettingsBloc();
    //   final ValueStream<Language> stream = settings.language;
    //   await Future.delayed(const Duration(seconds: 1));
    //   expect(stream, emits(Language.FI));
    // });

    // test('Translation works correctly', () async {
    //   final List<Phrase> data = [Phrase.routeToday, Phrase.failedSaveData];
    //   SharedPreferences.setMockInitialValues({});
    //   final SettingsBloc settings = SettingsBloc();
    //   for (var phrase in data) {
    //     expect(settings.translate(phrase), dictionaryEN[phrase]);
    //   }

    //   settings.changeLanguage(Language.FI);
    //   await Future.delayed(const Duration(seconds: 1));
    //   for (var phrase in data) {
    //     expect(settings.translate(phrase), dictionaryFI[phrase]);
    //   }
    // });
  });
}
