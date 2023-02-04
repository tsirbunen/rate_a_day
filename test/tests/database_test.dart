// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rate_a_day/packages/data_storage.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

Future main() async {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });
  group('Database', () {
    test("A day can be rated and the day's rating retrieved", () async {
      const Rating rating = Rating.HAPPY;
      const bool didLearnNew = true;
      final DateTime date = DateTime(2023, 2, 4, 12, 45);
      final DateTime dateRetrieved = DateTime(2023, 2, 4);

      await DataStorage.assessDay(rating, didLearnNew, date);
      final BuiltMap<int, DayData> retrievedData =
          await DataStorage.fetchDayDataByDate(DateTime.now());

      final DayData? dayData = retrievedData[4];
      expect(dayData, isNotNull);
      expect(dayData!.rating, rating);
      expect(dayData.didLearnNew, didLearnNew);
      expect(dayData.date, dateRetrieved);
      final Database d = await DataStorage.database();
      await d.close();
    });

    test("Only ratings for relevant month are retrieved", () async {
      final DateTime januaryDate = DateTime(2023, 1, 23, 12, 00);
      final DateTime februaryDate = DateTime(2023, 2, 11, 12, 00);

      await DataStorage.assessDay(
          Rating.HAPPY, false, DateTime(2023, 1, 12, 12, 00));
      await DataStorage.assessDay(Rating.HAPPY, false, januaryDate);

      await DataStorage.assessDay(
          Rating.HAPPY, true, DateTime(2023, 2, 4, 12, 00));
      await DataStorage.assessDay(
          Rating.UNHAPPY, true, DateTime(2023, 2, 5, 12, 00));
      await DataStorage.assessDay(
          Rating.MISSING, true, DateTime(2023, 2, 6, 12, 00));
      await DataStorage.assessDay(Rating.HAPPY, false, februaryDate);

      final BuiltMap<int, DayData> retrievedJanuaryData =
          await DataStorage.fetchDayDataByDate(januaryDate);
      expect(retrievedJanuaryData.keys, containsAll([12, 23]));
      expect(retrievedJanuaryData.keys, hasLength(2));

      final BuiltMap<int, DayData> retrievedFebruaryMonth =
          await DataStorage.fetchDayDataByDate(februaryDate);
      expect(retrievedFebruaryMonth.keys, containsAll([4, 5, 6, 11]));
      expect(retrievedFebruaryMonth.keys, hasLength(4));

      final Database d = await DataStorage.database();
      await d.close();
    });
  });
}
