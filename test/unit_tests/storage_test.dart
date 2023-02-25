// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rate_a_day/packages/storage.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

Future main() async {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });
  group('Data storage', () {
    test("A day can be rated and the day's rating retrieved", () async {
      const Rating rating = Rating.HAPPY;
      const bool didLearnNew = true;
      final DateTime date = DateTime(2023, 2, 4, 12, 45);
      final DateTime dateRetrieved = DateTime(2023, 2, 4);

      await Storage.assessDay(rating, didLearnNew, date);
      final BuiltMap<int, DayData> retrievedData =
          await Storage.fetchDayDataByDate(DateTime.now());

      final DayData? dayData = retrievedData[4];
      expect(dayData, isNotNull);
      expect(dayData!.rating, rating);
      expect(dayData.didLearnNew, didLearnNew);
      expect(dayData.date, dateRetrieved);
    });

    test("Only ratings for relevant month are retrieved", () async {
      final DateTime januaryDate = DateTime(2023, 1, 23, 12, 00);
      final DateTime februaryDate = DateTime(2023, 2, 11, 12, 00);

      await Storage.assessDay(
          Rating.HAPPY, false, DateTime(2023, 1, 12, 12, 00));
      await Storage.assessDay(Rating.HAPPY, false, januaryDate);

      await Storage.assessDay(Rating.HAPPY, true, DateTime(2023, 2, 4, 12, 00));
      await Storage.assessDay(
          Rating.UNHAPPY, true, DateTime(2023, 2, 5, 12, 00));
      await Storage.assessDay(
          Rating.MISSING, true, DateTime(2023, 2, 6, 12, 00));
      await Storage.assessDay(Rating.HAPPY, false, februaryDate);

      final BuiltMap<int, DayData> retrievedJanuaryData =
          await Storage.fetchDayDataByDate(januaryDate);
      expect(retrievedJanuaryData.keys, containsAll([12, 23]));
      expect(retrievedJanuaryData.keys, hasLength(2));

      final BuiltMap<int, DayData> retrievedFebruaryMonth =
          await Storage.fetchDayDataByDate(februaryDate);
      expect(retrievedFebruaryMonth.keys, containsAll([4, 5, 6, 11]));
      expect(retrievedFebruaryMonth.keys, hasLength(4));
    });
  });

  tearDown(() async {
    final Database d = await Storage.database();
    await Storage.emptyDatabase();
    await d.close();
  });
}
