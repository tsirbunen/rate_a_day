import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rate_a_day/main.dart' as app;
import 'package:rate_a_day/packages/localizations.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/storage.dart';
import 'package:rate_a_day/packages/utils.dart' as util;
import 'package:rate_a_day/packages/utils.dart';
import 'helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets(
      'After rating today the calendar (on month page) shows correct data',
      (final WidgetTester tester) async {
    app.main();
    await Storage.emptyDatabase();
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));

    await performEvaluation(tester, [happyIcon, didNotLearnIcon]);

    final DateTime today = DateTime.now();
    verifyCorrectMonthAndYear(tester, today);

    final Map<int, DayData> expectedDayData = {
      today.day: DayData(((b) => b
        ..rating = Rating.HAPPY
        ..didLearnNew = true
        ..date = DateTimeUtil.getStartOfDate(today)))
    };

    verifyCorrectMonthsDayData(tester, expectedDayData);
    verifyCorrectDayNumberColors(tester, ['${today.day}']);
    verifyCorrectStatistics(tester, 1, 0, 1);
    verifyIconWithColorCount(tester, happyIcon, 2, happyColor);
    verifyIconWithColorCount(tester, unhappyIcon, 1, noEvaluationColor);
    verifyIconWithColorCount(tester, didLearnIcon, 1, didLearnColor);
    verifyIconWithColorCount(tester, didNotLearnIcon, 0, null);
  });

  testWidgets('Calendar month can be changed',
      (final WidgetTester tester) async {
    app.main();
    await Storage.emptyDatabase();
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    await navigateToCalendar(tester);

    await selectPreviousMonth(tester);
    final DateTime today = DateTime.now();
    final DateTime previousMonthStart =
        util.DateTimeUtil.previousMonthStart(today);
    verifyCorrectMonthAndYear(tester, previousMonthStart);
  });

  testWidgets(
      'After rating several days the calendar (on month page) shows correct data',
      (final WidgetTester tester) async {
    app.main();
    await Storage.emptyDatabase();
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    await navigateToCalendar(tester);
    await selectPreviousMonth(tester);
    final DateTime startOfPreviousMonth =
        util.DateTimeUtil.previousMonthStart(DateTime.now());
    final int year = startOfPreviousMonth.year;
    final int month = startOfPreviousMonth.month;
    final Map<int, DayData> expectedData = {};

    await tapCalendarDayToOpenRatingPage(tester, 8);
    await performEvaluation(tester, [unhappyIcon]);
    addDataToExpectedData(expectedData, Rating.UNHAPPY, false, 8, month, year);

    await tapCalendarDayToOpenRatingPage(tester, 10);
    await performEvaluation(tester, [happyIcon, didNotLearnIcon]);
    addDataToExpectedData(expectedData, Rating.HAPPY, true, 10, month, year);

    await tapCalendarDayToOpenRatingPage(tester, 19);
    await performEvaluation(tester, [happyIcon, didNotLearnIcon]);
    addDataToExpectedData(expectedData, Rating.HAPPY, true, 19, month, year);

    await tapCalendarDayToOpenRatingPage(tester, 20);
    await performEvaluation(tester, [unhappyIcon, didNotLearnIcon]);
    addDataToExpectedData(expectedData, Rating.UNHAPPY, true, 20, month, year);

    await tapCalendarDayToOpenRatingPage(tester, 23);
    await performEvaluation(tester, [happyIcon]);
    addDataToExpectedData(expectedData, Rating.HAPPY, false, 23, month, year);

    verifyCorrectMonthsDayData(tester, expectedData);
    verifyCorrectDayNumberColors(tester, ['10', '19', '20']);
    verifyCorrectStatistics(tester, 3, 2, 3);
    verifyIconWithColorCount(tester, happyIcon, 3 + 1, happyColor);
    verifyIconWithColorCount(tester, unhappyIcon, 2 + 1, unhappyColor);
    verifyIconWithColorCount(tester, didLearnIcon, 1, didLearnColor);
    verifyIconWithColorCount(tester, didNotLearnIcon, 0, null);
  });

  testWidgets('Earlier evaluations can be modified later on',
      (final WidgetTester tester) async {
    app.main();
    await Storage.emptyDatabase();
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    await navigateToCalendar(tester);
    await selectPreviousMonth(tester);
    final DateTime startOfPreviousMonth =
        util.DateTimeUtil.previousMonthStart(DateTime.now());
    final int year = startOfPreviousMonth.year;
    final int month = startOfPreviousMonth.month;
    final Map<int, DayData> expectedData = {};

    await tapCalendarDayToOpenRatingPage(tester, 8);
    await performEvaluation(tester, [unhappyIcon]);

    await tapCalendarDayToOpenRatingPage(tester, 10);
    await performEvaluation(tester, [happyIcon, didNotLearnIcon]);

    await tapCalendarDayToOpenRatingPage(tester, 19);
    await performEvaluation(tester, [happyIcon, didNotLearnIcon]);

    await tapCalendarDayToOpenRatingPage(tester, 20);
    await performEvaluation(tester, [unhappyIcon, didNotLearnIcon]);
    addDataToExpectedData(expectedData, Rating.UNHAPPY, true, 20, month, year);

    await tapCalendarDayToOpenRatingPage(tester, 8);
    await performEvaluation(tester, [happyIcon, didNotLearnIcon]);
    addDataToExpectedData(expectedData, Rating.HAPPY, true, 8, month, year);

    await tapCalendarDayToOpenRatingPage(tester, 10);
    await performEvaluation(tester, [happyIcon]);
    addDataToExpectedData(expectedData, Rating.MISSING, true, 10, month, year);

    await tapCalendarDayToOpenRatingPage(tester, 19);
    await performEvaluation(tester, [unhappyIcon, didLearnIcon]);
    addDataToExpectedData(expectedData, Rating.UNHAPPY, false, 19, month, year);

    verifyCorrectMonthsDayData(tester, expectedData);
    verifyCorrectDayNumberColors(tester, ['8', '10', '20']);
    verifyCorrectStatistics(tester, 1, 2, 3);
    verifyIconWithColorCount(tester, happyIcon, 1 + 1, happyColor);
    verifyIconWithColorCount(tester, unhappyIcon, 2 + 1, unhappyColor);
    verifyIconWithColorCount(tester, didLearnIcon, 1, didLearnColor);
    verifyIconWithColorCount(tester, didNotLearnIcon, 0, null);
  });

  testWidgets('Future dates cannot be evaluated',
      (final WidgetTester tester) async {
    app.main();
    await Storage.emptyDatabase();
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    await navigateToCalendar(tester);

    final DateTime today = DateTime.now();
    final DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    if (tomorrow.month != today.month) {
      await selectNextMonth(tester);
    } else {
      await tapCalendarDayToOpenRatingPage(tester, tomorrow.day);
    }
    verifyRoutePage(Phrase.monthTitle, Phrase.monthSubtitle);
    verifyCorrectMonthAndYear(tester, today);
  });
}
