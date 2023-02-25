import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/utils.dart';
// import '../data/data.dart';

void main() {
  group('Day data operations', () {
    test('Statistics are calculated correctly', () {
      const int countDidLearn = 13;
      const int countHappy = 11;
      const int countUnhappy = 4;
      final BuiltMap<int, DayData> data = BuiltMap.from(testDayDataByDay);
      final Statistics statistics = DayDataOperations.calculateStatistics(data);
      expect(statistics.satisfiedCount, countHappy);
      expect(statistics.dissatisfiedCount, countUnhappy);
      expect(statistics.didLearnNewCount, countDidLearn);
    });

    test('Day data is correctly extracted from row data', () {
      final List<Map<String, Object?>> rowDataString = [
        {'rating': 'TRUE', 'didLearnNew': 'TRUE', 'date': 1675893600000},
        {'rating': 'TRUE', 'didLearnNew': 'TRUE', 'date': 1676152800000}
      ];

      final BuiltMap<int, DayData> data =
          DayDataOperations.extractDataFromRowData(rowDataString);
      expect(data.keys.length, 2);
      expect(data[9]!.rating, Rating.HAPPY);
      expect(data[9]!.didLearnNew, true);
      expect(data[12]!.date, DateTime(2023, 2, 12));
    });
  });
}

// import 'package:rate_a_day/packages/models.dart';

final Map<int, DayData> testDayDataByDay = {
  3: DayData(((b) => b
    ..rating = Rating.HAPPY
    ..didLearnNew = true
    ..date = DateTime(2023, 1, 3))),
  4: DayData(((b) => b
    ..rating = Rating.MISSING
    ..didLearnNew = true
    ..date = DateTime(2023, 1, 4))),
  5: DayData(((b) => b
    ..rating = Rating.UNHAPPY
    ..didLearnNew = true
    ..date = DateTime(2023, 1, 5))),
  6: DayData(((b) => b
    ..rating = Rating.HAPPY
    ..didLearnNew = false
    ..date = DateTime(2023, 1, 6))),
  9: DayData(((b) => b
    ..rating = Rating.UNHAPPY
    ..didLearnNew = true
    ..date = DateTime(2023, 1, 9))),
  10: DayData(((b) => b
    ..rating = Rating.HAPPY
    ..didLearnNew = false
    ..date = DateTime(2023, 1, 10))),
  13: DayData(((b) => b
    ..rating = Rating.UNHAPPY
    ..didLearnNew = true
    ..date = DateTime(2023, 1, 13))),
  16: DayData(((b) => b
    ..rating = Rating.HAPPY
    ..didLearnNew = true
    ..date = DateTime(2023, 1, 16))),
  17: DayData(((b) => b
    ..rating = Rating.HAPPY
    ..didLearnNew = false
    ..date = DateTime(2023, 1, 17))),
  18: DayData(((b) => b
    ..rating = Rating.MISSING
    ..didLearnNew = true
    ..date = DateTime(2023, 1, 18))),
  19: DayData(((b) => b
    ..rating = Rating.HAPPY
    ..didLearnNew = true
    ..date = DateTime(2023, 1, 19))),
  24: DayData(((b) => b
    ..rating = Rating.HAPPY
    ..didLearnNew = true
    ..date = DateTime(2023, 1, 24))),
  25: DayData(((b) => b
    ..rating = Rating.HAPPY
    ..didLearnNew = true
    ..date = DateTime(2023, 1, 25))),
  26: DayData(((b) => b
    ..rating = Rating.HAPPY
    ..didLearnNew = true
    ..date = DateTime(2023, 1, 26))),
  27: DayData(((b) => b
    ..rating = Rating.HAPPY
    ..didLearnNew = true
    ..date = DateTime(2023, 1, 27))),
  30: DayData(((b) => b
    ..rating = Rating.HAPPY
    ..didLearnNew = false
    ..date = DateTime(2023, 1, 30))),
  31: DayData(((b) => b
    ..rating = Rating.UNHAPPY
    ..didLearnNew = true
    ..date = DateTime(2023, 1, 31))),
};
