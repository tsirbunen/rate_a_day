import 'package:flutter_test/flutter_test.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/utils.dart';

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
  });
}
