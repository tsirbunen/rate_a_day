import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rate_a_day/packages/utils.dart';

void main() {
  group('Datetime util', () {
    test('Date is formatted correctly', () {
      final Map<String, DateTime> data = {
        '4.2.2023': DateTime(2023, 2, 4),
        '31.1.2023': DateTime(2023, 1, 31),
        '22.10.1922': DateTime(1922, 10, 22),
        '11.8.2003': DateTime(2003, 8, 11),
      };

      data.forEach((final String dateString, final DateTime date) {
        final String result = DateTimeUtil.getDate(date);
        expect(dateString, equals(result));
      });
    });

    test('Weekday is correct in English', () {
      final Map<String, DateTime> data = {
        'Saturday': DateTime(2023, 2, 4),
        'Monday': DateTime(2023, 2, 6),
        'Friday': DateTime(2023, 2, 3),
        'Wednesday': DateTime(2023, 1, 25),
      };

      data.forEach((final String weekday, final DateTime date) {
        final String result =
            DateTimeUtil.getWeekday(date.weekday, const Locale('en'));
        expect(result, equals(weekday));
      });
    });

    test('Weekday is correct in Finnish', () {
      final Map<String, DateTime> data = {
        'Lauantai': DateTime(2023, 2, 4),
        'Maanantai': DateTime(2023, 2, 6),
        'Perjantai': DateTime(2023, 2, 3),
        'Keskiviikko': DateTime(2023, 1, 25),
      };

      data.forEach((final String weekday, final DateTime date) {
        final String result =
            DateTimeUtil.getWeekday(date.weekday, const Locale('fi'));
        expect(result, equals(weekday));
      });
    });

    test('Month and year are correct in English', () {
      final Map<String, DateTime> data = {
        'February 2023': DateTime(2023, 2, 4),
        'January 2023': DateTime(2023, 1, 23),
        'December 2022': DateTime(2022, 12, 12),
        'August 2003': DateTime(2003, 8, 25),
      };

      data.forEach((final String monthAndYear, final DateTime date) {
        final String result =
            DateTimeUtil.getMonthAndYear(date, const Locale('en'), false);
        expect(result, equals(monthAndYear));
      });
    });

    test('Month and year are correct in Finnish', () {
      final Map<String, DateTime> data = {
        'Helmikuu 2023': DateTime(2023, 2, 4),
        'Tammikuu 2023': DateTime(2023, 1, 23),
        'Joulukuu 2022': DateTime(2022, 12, 12),
        'Elokuu 2003': DateTime(2003, 8, 25),
      };

      data.forEach((final String monthAndYear, final DateTime date) {
        final String result =
            DateTimeUtil.getMonthAndYear(date, const Locale('fi'), false);
        expect(result, equals(monthAndYear));
      });
    });

    test('Month and year are correct if month as number', () {
      final Map<String, DateTime> data = {
        '2/2023': DateTime(2023, 2, 4),
        '1/2023': DateTime(2023, 1, 23),
        '12/2022': DateTime(2022, 12, 12),
        '8/2003': DateTime(2003, 8, 25),
      };

      data.forEach((final String monthAndYear, final DateTime date) {
        final String result =
            DateTimeUtil.getMonthAndYear(date, const Locale('fi'), true);
        expect(result, equals(monthAndYear));
      });
    });

    test('Same dates are correctly identified', () {
      final List<dynamic> data = [
        [DateTime(2023, 2, 3, 12, 45), DateTime(2023, 2, 3, 18, 33), true],
        [DateTime(2023, 2, 4, 12, 45), DateTime(2023, 2, 3, 18, 33), false],
        [DateTime(2023, 2, 4), DateTime(2021, 2, 4), false],
        [DateTime(2022, 10, 4), DateTime(2022, 10, 4), true],
      ];

      for (var element in data) {
        final bool result = DateTimeUtil.areSameDate(element[0], element[1]);
        expect(result, equals(element[2]));
      }
    });

    test('Returns first day of previous month', () {
      final List<dynamic> data = [
        [DateTime(2023, 2, 4), DateTime(2023, 1, 1)],
        [DateTime(2022, 10, 4), DateTime(2022, 9, 1)],
        [DateTime(2022, 1, 4), DateTime(2021, 12, 1)],
        [DateTime(2022, 1, 31), DateTime(2021, 12, 1)],
      ];

      for (var element in data) {
        final DateTime result = DateTimeUtil.previousMonthStart(element[0]);
        expect(result, equals(element[1]));
      }
    });

    test('Returns first day of next month', () {
      final List<dynamic> data = [
        [DateTime(2023, 2, 4), DateTime(2023, 3, 1)],
        [DateTime(2022, 10, 4), DateTime(2022, 11, 1)],
        [DateTime(2022, 12, 4), DateTime(2023, 1, 1)],
        [DateTime(2022, 12, 31), DateTime(2023, 1, 1)],
      ];

      for (var element in data) {
        final DateTime result = DateTimeUtil.nextMonthStart(element[0]);
        expect(result, equals(element[1]));
      }
    });

    test('Returns milliseconds since epoch correctly', () {
      final Map<int, DateTime> data = {
        1675461600000: DateTime(2023, 2, 4),
        1675548000000: DateTime(2023, 2, 5, 12, 45),
        1048284000000: DateTime(2003, 3, 22, 18, 33)
      };

      data.forEach((final int milliseconds, final DateTime date) {
        final int result = DateTimeUtil.getStartOfDayEpochMilliseconds(date);
        expect(result, equals(milliseconds));
      });
    });

    test('Start of day is correct', () {
      final List<dynamic> data = [
        [DateTime(2023, 2, 4, 13, 45), DateTime(2023, 2, 4, 0, 0)],
        [DateTime(2023, 2, 4, 6, 22), DateTime(2023, 2, 4, 0, 0)],
        [DateTime(2022, 1, 13, 4, 15), DateTime(2022, 1, 13, 0, 0)],
        [DateTime(2021, 5, 22, 18, 30), DateTime(2021, 5, 22, 0, 0)],
      ];

      for (var element in data) {
        final DateTime result = DateTimeUtil.getStartOfDate(element[0]);
        expect(result, equals(element[1]));
      }
    });

    test('Correctly recognizes a date in future', () {
      final DateTime today = DateTime.now();
      final List<dynamic> data = [
        [DateTime(today.year, today.month, today.day), false],
        [DateTime(today.year, today.month, today.day, 12, 33), false],
        [DateTime(today.year + 1, today.month, today.day, 12, 33), true],
        [today.add(const Duration(days: 1)), true],
        [today.add(const Duration(days: -1)), false],
      ];

      for (var element in data) {
        final bool result = DateTimeUtil.isFutureDate(element[0]);
        expect(result, equals(element[1]));
      }
    });

    test('Correctly recognizes a date in history', () {
      final DateTime today = DateTime.now();
      final List<dynamic> data = [
        [DateTime(today.year, today.month, today.day), false],
        [DateTime(today.year, today.month, today.day, 12, 33), false],
        [DateTime(today.year - 1, today.month, today.day, 12, 33), true],
        [today.add(const Duration(days: 1)), false],
        [today.add(const Duration(days: -1)), true],
      ];

      for (var element in data) {
        final bool result = DateTimeUtil.isHistoryDate(element[0]);
        expect(result, equals(element[1]));
      }
    });

    test('Same month and year are correctly identified', () {
      final List<dynamic> data = [
        [DateTime(2023, 2, 3, 12, 45), DateTime(2023, 2, 3, 18, 33), true],
        [DateTime(2023, 2, 4, 12, 45), DateTime(2023, 1, 3, 18, 33), false],
        [DateTime(2023, 2, 4), DateTime(2021, 2, 4), false],
        [DateTime(2023, 2, 4), DateTime(2021, 2, 5), false],
        [DateTime(2022, 10, 4), DateTime(2022, 9, 4), false],
        [DateTime(2022, 10, 1), DateTime(2022, 10, 28), true],
      ];

      for (var element in data) {
        final bool result =
            DateTimeUtil.areSameMonthSameYear(element[0], element[1]);
        expect(result, equals(element[2]));
      }
    });

    test('Days of month are properly arranged', () {
      final Map<String, List<List<int?>>> data = {
        '2023-01-05 15:18:04Z': [
          [null, null, null, null, null, null, 1],
          [2, 3, 4, 5, 6, 7, 8],
          [9, 10, 11, 12, 13, 14, 15],
          [16, 17, 18, 19, 20, 21, 22],
          [23, 24, 25, 26, 27, 28, 29],
          [30, 31, null, null, null, null, null],
        ],
        '2023-02-05 14:28:03Z': [
          [null, null, 1, 2, 3, 4, 5],
          [6, 7, 8, 9, 10, 11, 12],
          [13, 14, 15, 16, 17, 18, 19],
          [20, 21, 22, 23, 24, 25, 26],
          [27, 28, null, null, null, null, null]
        ],
      };

      data.forEach((final String date, final List<List<int?>> days) {
        final List<List<int?>> result =
            DateTimeUtil.arrangeDaysOfMonth(DateTime.parse(date));
        expect(result, equals(days));
      });
    });

    test('DateTimeUtil returns correct month in English', () {
      final Map<int, String> data = {
        1: 'January',
        5: 'May',
        8: 'August',
        11: 'November',
      };

      data.forEach((final int monthNumber, final String monthName) {
        final String result =
            DateTimeUtil.getMonth(monthNumber, const Locale('en'));
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

      data.forEach((final int monthNumber, final String monthName) {
        final String result =
            DateTimeUtil.getMonth(monthNumber, const Locale('fi'));
        expect(result, equals(monthName));
      });
    });

    test('Translator returns correct weekday in English', () {
      final Map<int, String> data = {
        1: 'Monday',
        5: 'Friday',
        7: 'Sunday',
      };

      data.forEach((final int weekdayNumber, final String weekdayName) {
        final String result =
            DateTimeUtil.getWeekday(weekdayNumber, const Locale('en'));
        expect(result, equals(weekdayName));
      });
    });

    test('Translator returns correct weekday in Finnish', () {
      final Map<int, String> data = {
        1: 'Maanantai',
        5: 'Perjantai',
        7: 'Sunnuntai',
      };

      data.forEach((final int weekdayNumber, final String weekdayName) {
        final String result =
            DateTimeUtil.getWeekday(weekdayNumber, const Locale('fi'));
        expect(result, equals(weekdayName));
      });
    });

    test('Translator returns correct day abbreviations in English', () {
      final List<String> data = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

      final List<String> result =
          DateTimeUtil.getDayAbbreviations(const Locale('en'));
      expect(result, equals(data));
    });

    test('Translator returns correct day abbreviations in Finnish', () {
      final List<String> data = ['M', 'T', 'K', 'T', 'P', 'L', 'S'];

      final List<String> result =
          DateTimeUtil.getDayAbbreviations(const Locale('fi'));
      expect(result, equals(data));
    });
  });
}
