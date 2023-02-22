import 'package:flutter_test/flutter_test.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/localizations.dart';

void main() {
  group('Translator', () {
    test('All dictionaries have all translations', () {
      final List<Translator> translators = [
        Translator(Language.EN),
        Translator(Language.FI),
      ];

      for (var phrase in Phrase.values) {
        for (var translator in translators) {
          final String translation = translator.get(phrase);
          expect(translation, isNotEmpty);
        }
      }
    });

    test('Translators return values from correct dictionary', () {
      Translator translator = Translator(Language.EN);
      const Phrase phrase = Phrase.routeToday;
      String translation = dictionaryEN[phrase]!;
      expect(translator.get(phrase), translation);
      translator = Translator(Language.FI);
      translation = dictionaryFI[phrase]!;
      expect(translator.get(phrase), translation);
    });

    test('Translator language can be changed', () {
      final Translator translator = Translator(Language.EN);
      Phrase phrase = Phrase.routeToday;
      String translation = dictionaryEN[phrase]!;
      expect(translator.get(phrase), translation);
      translator.setDictionary(Language.FI);
      translation = dictionaryFI[phrase]!;
      expect(translator.get(phrase), translation);
    });
    test('Translator returns correct month in English', () {
      final Map<int, String> data = {
        1: 'January',
        5: 'May',
        8: 'August',
        11: 'November',
      };

      final Translator translator = Translator(Language.EN);
      data.forEach((final int monthNumber, final String monthName) {
        final String result = translator.getMonth(monthNumber);
        expect(result, equals(monthName));
      });
    });

    test('Translator returns correct month in Finnish', () {
      final Map<int, String> data = {
        1: 'Tammikuu',
        5: 'Toukokuu',
        8: 'Elokuu',
        11: 'Marraskuu',
      };

      final Translator translator = Translator(Language.FI);
      data.forEach((final int monthNumber, final String monthName) {
        final String result = translator.getMonth(monthNumber);
        expect(result, equals(monthName));
      });
    });

    test('Translator returns correct weekday in English', () {
      final Map<int, String> data = {
        1: 'Monday',
        5: 'Friday',
        7: 'Sunday',
      };

      final Translator translator = Translator(Language.EN);
      data.forEach((final int weekdayNumber, final String weekdayName) {
        final String result = translator.getWeekday(weekdayNumber);
        expect(result, equals(weekdayName));
      });
    });

    test('Translator returns correct weekday in Finnish', () {
      final Map<int, String> data = {
        1: 'Maanantai',
        5: 'Perjantai',
        7: 'Sunnuntai',
      };

      final Translator translator = Translator(Language.FI);
      data.forEach((final int weekdayNumber, final String weekdayName) {
        final String result = translator.getWeekday(weekdayNumber);
        expect(result, equals(weekdayName));
      });
    });

    test('Translator returns correct day abbreviations in English', () {
      final List<String> data = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
      final Translator translator = Translator(Language.EN);
      final List<String> result = translator.getDayAbbreviations();
      expect(result, equals(data));
    });

    test('Translator returns correct day abbreviations in Finnish', () {
      final List<String> data = ['M', 'T', 'K', 'T', 'P', 'L', 'S'];
      final Translator translator = Translator(Language.FI);
      final List<String> result = translator.getDayAbbreviations();
      expect(result, equals(data));
    });
  });
}
