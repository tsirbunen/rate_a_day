import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/storage.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });
  group('Data bloc', () {
    test('Rating a day updates the respective stream correctly', () async {
      final DataBloc dataBloc = DataBloc();
      final ValueStream<Rating> stream = dataBloc.rating;

      dataBloc.rate(Rating.HAPPY);
      expect(stream, emits(Rating.HAPPY));
      dataBloc.rate(Rating.UNHAPPY);
      expect(stream, emits(Rating.UNHAPPY));
      dataBloc.rate(Rating.UNHAPPY);
      expect(stream, emits(Rating.MISSING));
      dataBloc.rate(Rating.UNHAPPY);
      expect(stream, emits(Rating.UNHAPPY));
    });

    test('Toggling did learn new updates the respective stream correctly',
        () async {
      final DataBloc dataBloc = DataBloc();
      final ValueStream<bool> stream = dataBloc.didLearnNew;

      dataBloc.toggleDidLearn(true);
      expect(stream, emits(true));
      dataBloc.toggleDidLearn(false);
      expect(stream, emits(false));
      dataBloc.toggleDidLearn(false);
      expect(stream, emits(false));
      dataBloc.toggleDidLearn(true);
      expect(stream, emits(true));
    });

    test("Day's data can be saved and retrieved from data storage", () async {
      final DataBloc dataBloc = DataBloc();
      dataBloc.rate(Rating.HAPPY);
      dataBloc.toggleDidLearn(true);
      final ValueStream<BuiltMap<int, DayData>> stream = dataBloc.monthsData;
      final DateTime today = DateTime.now();
      final DateTime startOfToday = DateTimeUtil.getStartOfDate(today);

      await dataBloc.saveData();
      final BuiltMap<int, DayData> streamData = stream.value;
      expect(streamData.keys.length, 1);
      expect(streamData[startOfToday.day], isNotNull);
      expect(streamData[startOfToday.day]!.rating, Rating.HAPPY);
      expect(streamData[startOfToday.day]!.didLearnNew, true);
      expect(streamData[startOfToday.day]!.date, startOfToday);
    });

    test(
        "After changing focus dates and saving data, all streams are properly updated",
        () async {
      final DataBloc dataBloc = DataBloc();

      final DateTime firstFocusDate =
          DateTimeUtil.getStartOfDate(DateTime(2023, 2, 6));
      dataBloc.changeFocusDate(firstFocusDate);
      dataBloc.rate(Rating.HAPPY);
      dataBloc.toggleDidLearn(true);
      await dataBloc.saveData();

      final DateTime secondFocusDate =
          DateTimeUtil.getStartOfDate(DateTime(2023, 1, 8));
      dataBloc.changeFocusDate(secondFocusDate);
      expect(dataBloc.rating.value, Rating.MISSING);
      expect(dataBloc.didLearnNew.value, false);
      expect(dataBloc.focusDate.value, secondFocusDate);
      expect(dataBloc.status.value, Status.READY);
      dataBloc.rate(Rating.UNHAPPY);
      dataBloc.toggleDidLearn(false);
      await dataBloc.saveData();
      final ValueStream<BuiltMap<int, DayData>> stream = dataBloc.monthsData;
      BuiltMap<int, DayData> streamData = stream.value;
      expect(streamData.keys.length, 1);
      expect(streamData[secondFocusDate.day], isNotNull);
      expect(streamData[secondFocusDate.day]!.rating, Rating.UNHAPPY);
      expect(streamData[secondFocusDate.day]!.didLearnNew, false);
      expect(streamData[secondFocusDate.day]!.date, secondFocusDate);

      dataBloc.changeFocusDate(firstFocusDate);
      await Future.delayed(const Duration(seconds: 1));
      expect(dataBloc.rating.value, Rating.HAPPY);
      expect(dataBloc.didLearnNew.value, true);
      expect(dataBloc.focusDate.value, firstFocusDate);
      streamData = stream.value;
      expect(streamData.keys.length, 1);
      expect(streamData[firstFocusDate.day], isNotNull);
      expect(streamData[firstFocusDate.day]!.rating, Rating.HAPPY);
      expect(streamData[firstFocusDate.day]!.didLearnNew, true);
      expect(dataBloc.status.value, Status.READY);
    });

    test("Old data can be later updated", () async {
      final DataBloc dataBloc = DataBloc();

      final DateTime firstFocusDate =
          DateTimeUtil.getStartOfDate(DateTime(2023, 1, 12));
      dataBloc.changeFocusDate(firstFocusDate);
      dataBloc.rate(Rating.HAPPY);
      dataBloc.toggleDidLearn(true);
      await dataBloc.saveData();

      final DateTime secondFocusDate =
          DateTimeUtil.getStartOfDate(DateTime(2023, 2, 8));
      dataBloc.changeFocusDate(secondFocusDate);
      await Future.delayed(const Duration(seconds: 1));
      final ValueStream<BuiltMap<int, DayData>> stream = dataBloc.monthsData;
      BuiltMap<int, DayData> streamData = stream.value;
      expect(streamData.keys.length, 0);

      dataBloc.changeFocusDate(firstFocusDate);
      dataBloc.rate(Rating.UNHAPPY);
      dataBloc.toggleDidLearn(false);
      await dataBloc.saveData();
      streamData = stream.value;
      expect(streamData.keys.length, 1);
      expect(streamData[firstFocusDate.day], isNotNull);
      expect(streamData[firstFocusDate.day]!.rating, Rating.UNHAPPY);
      expect(streamData[firstFocusDate.day]!.didLearnNew, false);
    });

    test('Evaluations update the status correctly (unevaluated day)', () async {
      final DataBloc dataBloc = DataBloc();
      final ValueStream<Status> stream = dataBloc.status;

      dataBloc.rate(Rating.HAPPY);
      expect(stream, emits(Status.DIRTY));
      dataBloc.toggleDidLearn(true);
      expect(stream, emits(Status.DIRTY));
      dataBloc.rate(Rating.HAPPY);
      expect(stream, emits(Status.DIRTY));
      dataBloc.toggleDidLearn(false);
      expect(stream, emits(Status.READY));
    });

    test("Day's data can be saved and retrieved from data storage", () async {
      final DataBloc dataBloc = DataBloc();

      final DateTime firstFocusDate =
          DateTimeUtil.getStartOfDate(DateTime(2023, 2, 6));
      dataBloc.changeFocusDate(firstFocusDate);
      dataBloc.rate(Rating.HAPPY);
      dataBloc.toggleDidLearn(true);
      await dataBloc.saveData();

      final DateTime secondFocusDate =
          DateTimeUtil.getStartOfDate(DateTime(2023, 1, 8));
      dataBloc.changeFocusDate(secondFocusDate);
      dataBloc.rate(Rating.UNHAPPY);
      dataBloc.toggleDidLearn(false);
      await dataBloc.saveData();

      dataBloc.changeFocusDate(firstFocusDate);
      await Future.delayed(const Duration(seconds: 1));

      final ValueStream<Status> stream = dataBloc.status;
      expect(stream, emits(Status.READY));
      dataBloc.rate(Rating.UNHAPPY);
      expect(stream, emits(Status.DIRTY));
      dataBloc.rate(Rating.HAPPY);
      expect(stream, emits(Status.READY));
    });
  });

  tearDown(() async {
    await Storage.emptyDatabase();
    await Storage.closeDatabase();
  });
}
