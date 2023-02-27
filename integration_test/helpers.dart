import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rate_a_day/packages/localizations.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/theme.dart';
import 'package:rate_a_day/packages/utils.dart' as util;
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/widgets.dart';

final happyIcon = util.Evaluations.getIcon(util.Evaluation.satisfied);
final unhappyIcon = util.Evaluations.getIcon(util.Evaluation.dissatisfied);
final didLearnIcon = util.Evaluations.getIcon(util.Evaluation.didLearn);
final didNotLearnIcon = util.Evaluations.getIcon(util.Evaluation.didNotLearn);
final Color didLearnColor = StyleUtil.didLearn(themeData);
final Color notSelectedColor = StyleUtil.notSelected(themeData);
final Color happyColor = StyleUtil.happy(themeData);
final Color unhappyColor = StyleUtil.unhappy(themeData);
final Color calendarColor = StyleUtil.calendarDayNumber(themeData);
final Color noEvaluationColor = StyleUtil.noEvaluation(themeData);

openMenuAndTapTargetRouteButton(
    final WidgetTester tester, final IconData iconData) async {
  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle();
  await tester.tap(find.byIcon(iconData));
  await tester.pumpAndSettle();
}

verifyRoutePage(final Phrase title, final Phrase? subtitle) {
  String titleString = dictionaryEN[title]!;
  expect(find.text(titleString), findsWidgets);
  if (subtitle == null) return;
  String subtitleString = dictionaryEN[subtitle]!;
  expect(find.text(subtitleString), findsOneWidget);
}

Future<void> performEvaluation(
    final WidgetTester tester, final List<IconData> iconsToTap) async {
  for (var iconData in iconsToTap) {
    await tester.tap(find.byIcon(iconData));
    await tester.pumpAndSettle();
  }
  await tester.tap(find.byType(ElevatedButton));
  await Future.delayed(const Duration(seconds: 3));
  await tester.pumpAndSettle();
}

void verifyCorrectMonthAndYear(final WidgetTester tester, final DateTime date) {
  final String monthAndYear =
      DateTimeUtil.getMonthAndYear(date, const Locale('en'), false);
  expect(find.text(monthAndYear), findsOneWidget);
}

void verifyCorrectMonthsDayData(
    final WidgetTester tester, final Map<int, DayData> expectedDayData) {
  final List<CalendarDay> calendarDayWidgets =
      tester.widgetList<CalendarDay>(find.byType(CalendarDay)).toList();

  for (var widget in calendarDayWidgets) {
    final DayData? data = expectedDayData.containsKey(widget.day)
        ? expectedDayData[widget.day]
        : null;
    if (data == null) {
      expect(widget.dayData, isNull);
    } else {
      expect(widget.dayData, isNotNull);
      expect(widget.dayData!.rating, data.rating);
      expect(widget.dayData!.didLearnNew, data.didLearnNew);
      expect(widget.dayData!.date, data.date);
    }
  }
}

void verifyCorrectDayNumberColors(
    final WidgetTester tester, final List<String> didLearnDays) {
  final Finder dayNumberFinder = find.descendant(
      of: find.byType(CalendarDay), matching: find.byType(Text));
  final List<Text> dayNumberWidgets =
      tester.widgetList<Text>(dayNumberFinder).toList();
  for (var widget in dayNumberWidgets) {
    final Color color = widget.style!.color!;
    final Color expectedColor =
        didLearnDays.contains(widget.data) ? didLearnColor : calendarColor;
    expect(color, expectedColor);
  }
}

void verifyCumulatedElementData(
    final WidgetTester tester,
    final Cumulated widget,
    final int count,
    final IconData iconData,
    final Color expectedIconColor) {
  expect(widget.value, count);

  final Finder iconFinder = find.descendant(
      of: find.byType(Cumulated), matching: find.byIcon(iconData));
  final Icon icon = tester.widget(iconFinder);
  final Color expectedColor = count > 0 ? expectedIconColor : noEvaluationColor;
  expect(icon.color, expectedColor);
}

void verifyCorrectStatistics(final WidgetTester tester, final int happyCount,
    final int unhappyCount, final int didLearnCount) {
  final List<Cumulated> widgets =
      tester.widgetList<Cumulated>(find.byType(Cumulated)).toList();
  while (widgets.isNotEmpty) {
    final Cumulated widget = widgets.removeAt(0);
    if (widget.evaluation == util.Evaluation.satisfied) {
      verifyCumulatedElementData(
          tester, widget, happyCount, happyIcon, happyColor);
    } else if (widget.evaluation == util.Evaluation.dissatisfied) {
      verifyCumulatedElementData(
          tester, widget, unhappyCount, unhappyIcon, unhappyColor);
    } else {
      verifyCumulatedElementData(
          tester, widget, didLearnCount, didLearnIcon, didLearnColor);
    }
  }
}

void verifyIconWithColorCount(final WidgetTester tester, final IconData icon,
    final int expectedCount, final Color? expectedColor) {
  if (expectedCount == 0) {
    expect(find.byIcon(icon), findsNothing);
    return;
  }
  final List<Icon> icons = tester.widgetList<Icon>(find.byIcon(icon)).toList();
  int count = 0;
  for (var icon in icons) {
    if (icon.color == expectedColor) count++;
  }
  expect(count, expectedCount);
}

Future<void> tapCalendarDayToOpenRatingPage(
    final WidgetTester tester, final int day) async {
  final Finder calendarDayFinder =
      find.ancestor(of: find.text('$day'), matching: find.byType(CalendarDay));
  final Finder toTapFinder =
      find.descendant(of: calendarDayFinder, matching: find.byType(InkWell));
  await tester.tap(toTapFinder);
  await Future.delayed(const Duration(seconds: 3));
  await tester.pumpAndSettle();
}

Future<void> navigateToCalendar(final WidgetTester tester) async {
  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle();
  await tester.tap(find.byIcon(Icons.calendar_month));
  await Future.delayed(const Duration(seconds: 2));
  await tester.pumpAndSettle();
}

Future<void> selectPreviousMonth(final WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.chevron_left));
  await Future.delayed(const Duration(seconds: 2));
  await tester.pumpAndSettle();
}

Future<void> selectNextMonth(final WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.chevron_right));
  await Future.delayed(const Duration(seconds: 2));
  await tester.pumpAndSettle();
}

void addDataToExpectedData(
    final Map<int, DayData> expectedData,
    final Rating rating,
    final bool didLearnNew,
    final int day,
    final int month,
    final int year) {
  expectedData[day] = DayData(((b) => b
    ..rating = rating
    ..didLearnNew = didLearnNew
    ..date = DateTime(year, month, day)));
}

void verifyCorrectTranslation(final WidgetTester tester,
    final Locale currentLocale, final Phrase phrase) {
  final Map<Phrase, String> dictionary =
      currentLocale.languageCode == 'fi' ? dictionaryFI : dictionaryEN;
  String titleString = dictionary[phrase]!;
  expect(find.text(titleString), findsWidgets);
}

Future<void> changeLanguage(final WidgetTester tester,
    final Locale currentLocale, final Locale newLocale) async {
  final String targetText = currentLocale.languageCode == 'en'
      ? dictionaryEN[Phrase.finnish]!
      : dictionaryFI[Phrase.english]!;

  final Finder radioRowFinder =
      find.ancestor(of: find.text(targetText), matching: find.byType(Row));
  final Finder radioFinder =
      find.descendant(of: radioRowFinder, matching: find.byType(Radio<Locale>));
  await tester.tap(radioFinder);
  await Future.delayed(const Duration(seconds: 2));
  await tester.pumpAndSettle();
}
