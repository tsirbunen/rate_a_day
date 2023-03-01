import 'dart:convert';
import 'package:built_collection/built_collection.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/utils.dart';

class WebDayData {
  static List<String> toOneDaysStringList(
      final int dateMilliseconds, final Rating rating, final bool didLearnNew) {
    final String ratingString = rating == Rating.HAPPY
        ? '1'
        : rating == Rating.UNHAPPY
            ? '2'
            : '3';
    final String didLearnString = didLearnNew ? '1' : '0';
    return ['$dateMilliseconds', ratingString, didLearnString];
  }

  static BuiltMap<int, DayData> toDayData(
      Map<String, dynamic> monthsDataAsLists) {
    final Map<int, DayData> data = {};
    monthsDataAsLists.forEach((final String key, final dynamic value) {
      final DateTime date =
          DateTime.fromMillisecondsSinceEpoch(int.parse(value[0]));
      final Rating rating = value[1] == '1'
          ? Rating.HAPPY
          : value[1] == '2'
              ? Rating.UNHAPPY
              : Rating.MISSING;
      final bool didLearnNew = value[2] == '1';
      final int dayNumber = date.day;
      data[dayNumber] = DayData(((b) => b
        ..rating = rating
        ..didLearnNew = didLearnNew
        ..date = date));
    });
    return BuiltMap.from(data);
  }
}

class StorageHandler {
  static Future<void> assessDay(
    final Rating rating,
    final bool didLearnNew,
    final DateTime date,
  ) async {
    final int startOfDay = DateTimeUtil.getStartOfDayEpochMilliseconds(date);
    final List<String> webDayData =
        WebDayData.toOneDaysStringList(startOfDay, rating, didLearnNew);

    final String thisMonthYearKey = DateTimeUtil.getStorageMonthAndYear(date);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? existingData = prefs.getString(thisMonthYearKey);
    final Map<String, dynamic> monthsData =
        existingData != null ? jsonDecode(existingData) : {};
    monthsData['$startOfDay'] = webDayData;

    final String encodedMonthsData = jsonEncode(monthsData);
    await prefs.setString(thisMonthYearKey, encodedMonthsData);
  }

  static Future<BuiltMap<int, DayData>> fetchDayDataByDate(
      final DateTime dateTime) async {
    final String thisMonthYearKey =
        DateTimeUtil.getStorageMonthAndYear(dateTime);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? existingData = prefs.getString(thisMonthYearKey);

    if (existingData == null) {
      return BuiltMap.from({});
    } else {
      return WebDayData.toDayData(jsonDecode(existingData));
    }
  }

  static Future<void> emptyDatabase() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Set<String> keys = prefs.getKeys();
    for (var key in keys) {
      if (key != localePrefsKey) {
        prefs.remove(key);
      }
    }
  }

  static Future<void> closeDatabase() async {}
}
