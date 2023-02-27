import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/theme.dart';
import 'package:rate_a_day/packages/utils.dart' as utils;
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rate_a_day/packages/models.dart';

final IconData happyIcon =
    utils.Evaluations.getIcon(utils.Evaluation.satisfied);
final IconData unhappyIcon =
    utils.Evaluations.getIcon(utils.Evaluation.dissatisfied);
final Finder happyFinder = find.byIcon(happyIcon);
final Finder unhappyFinder = find.byIcon(unhappyIcon);
final Color happyColor = StyleUtil.happy(themeData);
final Color unhappyColor = StyleUtil.unhappy(themeData);
final Color notSelectedColor = StyleUtil.notSelected(themeData);

void main() {
  late DataBloc dataBloc;
  late ValueStream<Rating> stream;

  _setUpOneTest(final WidgetTester tester) async {
    dataBloc = DataBloc();
    stream = dataBloc.rating;
    final Widget widget = BlocProvider(
      bloc: dataBloc,
      blocDisposer: (final DataBloc dataBloc) => dataBloc.dispose(),
      child: MaterialApp(
        theme: themeData,
        home: const Scaffold(
          body: Center(
            child: HappyOrNotSelection(),
          ),
        ),
      ),
    );

    await tester.pumpWidget(widget);
  }

  _tapIconThenVerifyColorAndRating(final WidgetTester tester,
      final Finder finder, final Rating rating, final Color color) async {
    Icon buttonIcon = tester.widget<Icon>(finder);
    await tester.tap(finder);
    await tester.pumpAndSettle();
    buttonIcon = tester.widget<Icon>(finder);
    expect(buttonIcon.color, color);
    expect(stream, emits(rating));
  }

  testWidgets(
      'Tapping happy icon changes happy icon color and emits HAPPY or MISSING ratings',
      (final WidgetTester tester) async {
    await _setUpOneTest(tester);

    Icon happyButton = tester.widget<Icon>(happyFinder);
    expect(happyButton.color, notSelectedColor);

    await _tapIconThenVerifyColorAndRating(
        tester, happyFinder, Rating.HAPPY, happyColor);

    await _tapIconThenVerifyColorAndRating(
        tester, happyFinder, Rating.MISSING, notSelectedColor);
  });

  testWidgets(
      'Tapping unhappy icon changes unhappy icon color and emits UNHAPPY or MISSING ratings',
      (final WidgetTester tester) async {
    await _setUpOneTest(tester);

    Icon unhappyButton = tester.widget<Icon>(unhappyFinder);
    expect(unhappyButton.color, notSelectedColor);

    await _tapIconThenVerifyColorAndRating(
        tester, unhappyFinder, Rating.UNHAPPY, unhappyColor);

    await _tapIconThenVerifyColorAndRating(
        tester, unhappyFinder, Rating.MISSING, notSelectedColor);
  });

  testWidgets(
      'Tapping happy and unhappy icons back and forth causes expected color and rating changes',
      (final WidgetTester tester) async {
    await _setUpOneTest(tester);

    await _tapIconThenVerifyColorAndRating(
        tester, happyFinder, Rating.HAPPY, happyColor);

    await _tapIconThenVerifyColorAndRating(
        tester, unhappyFinder, Rating.UNHAPPY, unhappyColor);

    await _tapIconThenVerifyColorAndRating(
        tester, happyFinder, Rating.HAPPY, happyColor);

    await _tapIconThenVerifyColorAndRating(
        tester, unhappyFinder, Rating.UNHAPPY, unhappyColor);

    await _tapIconThenVerifyColorAndRating(
        tester, unhappyFinder, Rating.MISSING, notSelectedColor);
  });
}
