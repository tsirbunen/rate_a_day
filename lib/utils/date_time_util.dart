import 'package:rate_a_day/packages/utils.dart';

class DateTimeUtil {
  static String getDate(final DateTime dateTime) {
    final year = dateTime.year;
    final month = dateTime.month;
    final day = dateTime.day;
    return '$day.$month.$year';
  }

  static String getWeekday(
      final DateTime dateTime, final Translator translator) {
    final weekday = dateTime.weekday;
    return translator.getWeekday(weekday);
  }

  static String getMonthAndYear(
      final DateTime dateTime, final Translator translator) {
    final year = dateTime.year;
    final month = translator.getMonth(dateTime.month);
    return '$month $year';
  }

  static bool areSameDate(final DateTime dateTime1, final DateTime dateTime2) {
    return dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month &&
        dateTime1.day == dateTime2.day;
  }

  static DateTime previousMonthStart(final DateTime dateTime) {
    final int year = dateTime.year;
    final month = dateTime.month;
    final yearToSet = month == 1 ? year - 1 : year;
    final monthToSet = month == 1 ? 12 : month - 1;
    return DateTime(yearToSet, monthToSet, 1);
  }

  static DateTime nextMonthStart(final DateTime dateTime) {
    final int year = dateTime.year;
    final month = dateTime.month;
    final yearToSet = month == 12 ? year + 1 : year;
    final monthToSet = month == 12 ? 1 : month + 1;
    return DateTime(yearToSet, monthToSet, 1);
  }

  // Returns the milliseconds of UTC datetime at 00.00.00.
  // For example, Sat Feb 04 2023 00:00:00 GMT+0200 and
  // Sat Feb 04 2023 15:45:00 GMT+0200 should both return
  // the same value of 1675461600000
  static int getStartOfDayEpochMilliseconds(final DateTime datetime) {
    return DateTime(datetime.year, datetime.month, datetime.day)
        .millisecondsSinceEpoch;
  }

  static DateTime getStartOfDate(final DateTime datetime) {
    return DateTime(datetime.year, datetime.month, datetime.day);
  }

  static bool isFutureDate(final DateTime datetime) {
    final DateTime startOfToday = DateTimeUtil.getStartOfDate(DateTime.now());
    final DateTime startOfDatetime = DateTimeUtil.getStartOfDate(datetime);
    return startOfDatetime.compareTo(startOfToday) > 0;
  }

  static bool isHistoryDate(final DateTime datetime) {
    final DateTime startOfToday = DateTimeUtil.getStartOfDate(DateTime.now());
    final DateTime startOfDatetime = DateTimeUtil.getStartOfDate(datetime);
    return startOfDatetime.compareTo(startOfToday) < 0;
  }

  static bool areSameMonthSameYear(
      final DateTime? date1, final DateTime? date2) {
    if (date1 == null) return false;
    if (date2 == null) return false;
    return date1.year == date2.year && date1.month == date2.month;
  }

  static List<List<int?>> arrangeDaysOfMonth(final DateTime dateTime) {
    final int targetMonth = dateTime.month;
    final int year = dateTime.year;
    DateTime focusDate = DateTime(year, targetMonth, 1);
    final firstWeekday = focusDate.weekday;
    List<List<int?>> allDays = [];
    List<int?> daysOfWeek = [];
    int currentWeekday = 1;
    for (var i = 0; i < firstWeekday - currentWeekday; i++) {
      daysOfWeek.add(null);
    }
    while (true) {
      if (daysOfWeek.length == 7) {
        allDays.add(daysOfWeek.toList());
        daysOfWeek = [];
      }
      final month = focusDate.month;
      if (month != targetMonth) {
        if (daysOfWeek.isNotEmpty) {
          final int count = 7 - daysOfWeek.length;
          for (var j = 0; j < count; j++) {
            daysOfWeek.add(null);
          }
          allDays.add(daysOfWeek.toList());
        }
        break;
      }
      daysOfWeek.add(focusDate.day);
      focusDate = focusDate.add(const Duration(days: 1));
    }
    return allDays;
  }
}
