import 'package:built_collection/built_collection.dart';
import 'package:rate_a_day/packages/models.dart';

class DayDataOperations {
  static BuiltMap<int, DayData> arrangeDayDataByDay(
      BuiltList<DayData> dayDataList) {
    final Map<int, DayData> dayData = {};
    for (var data in dayDataList) {
      final int day = data.date.day;
      dayData[day] = data;
    }
    return BuiltMap.from(dayData);
  }

  static Statistics calculateStatistics(final BuiltMap<int, DayData> dayData) {
    int satisfiedCount = 0;
    int dissatisfiedCount = 0;
    int didLearnNewCount = 0;

    dayData.forEach((final int day, final DayData data) {
      if (data.rating == Rating.HAPPY) {
        satisfiedCount += 1;
      } else if (data.rating == Rating.UNHAPPY) {
        dissatisfiedCount += 1;
      }
      if (data.didLearnNew) {
        didLearnNewCount += 1;
      }
    });

    return Statistics(((b) => b
      ..satisfiedCount = satisfiedCount
      ..dissatisfiedCount = dissatisfiedCount
      ..didLearnNewCount = didLearnNewCount));
  }

// NOTE: The package sqflite does not export the class QueryResultSet.
// Therefore row data is extracted via converting to a string as below.
  static BuiltMap<int, DayData> extractDataFromRowData(
      List<Map<String, Object?>> daydata) {
    if (daydata.isEmpty) return BuiltMap.from({});
    final data = daydata.map((final Object dataForDay) {
      final List<String> fields = dataForDay
          .toString()
          .replaceAll('{', '')
          .replaceAll('}', '')
          .split(', ');
      final Map<String, dynamic> dataMap = {};
      for (var element in fields) {
        final List<String> keyAndValue = element.split(": ");
        final String key = keyAndValue[0];
        final String value = keyAndValue[1];
        if (key == 'date') {
          dataMap['date'] =
              DateTime.fromMillisecondsSinceEpoch(int.parse(value));
        } else if (key == 'rating') {
          dataMap['rating'] = value == 'TRUE'
              ? Rating.HAPPY
              : value == 'FALSE'
                  ? Rating.UNHAPPY
                  : Rating.MISSING;
        } else if (key == 'didLearnNew') {
          dataMap['didLearnNew'] = value == 'TRUE' ? true : false;
        }
      }

      return DayData(((b) => b
        ..rating = dataMap['rating']
        ..didLearnNew = dataMap['didLearnNew']
        ..date = dataMap['date']));
    });

    return DayDataOperations.arrangeDayDataByDay(data.toBuiltList());
  }
}
