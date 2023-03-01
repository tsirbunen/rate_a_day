import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:rate_a_day/packages/models.dart';
import './web_storage.dart' as web;
import './mobile_storage.dart' as mobile;

class Storage {
  static Future<void> assessDay(
    final Rating rating,
    final bool didLearnNew,
    final DateTime date,
  ) async {
    if (kIsWeb) {
      return await web.StorageHandler.assessDay(rating, didLearnNew, date);
    }
    await mobile.StorageHandler.assessDay(rating, didLearnNew, date);
  }

  static Future<BuiltMap<int, DayData>> fetchDayDataByDate(
      final DateTime dateTime) async {
    if (kIsWeb) {
      return web.StorageHandler.fetchDayDataByDate(dateTime);
    }
    return mobile.StorageHandler.fetchDayDataByDate(dateTime);
  }

  static Future<void> emptyDatabase() async {
    if (kIsWeb) {
      return web.StorageHandler.emptyDatabase();
    }
    await mobile.StorageHandler.emptyDatabase();
  }

  static Future<void> closeDatabase() async {
    if (kIsWeb) return;
    await mobile.StorageHandler.closeDatabase();
  }
}
