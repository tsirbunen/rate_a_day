import 'package:flutter_test/flutter_test.dart';
import 'package:rate_a_day/packages/localizations.dart';

void main() {
  group('Translator', () {
    test('All dictionaries have all translations', () {
      final List<Map<Phrase, String>> dictionaries = [
        dictionaryEN,
        dictionaryFI,
      ];

      for (var phrase in Phrase.values) {
        for (var dict in dictionaries) {
          final String? translation = dict[phrase];
          expect(translation, isNotNull);
        }
      }
    });
  });
}
