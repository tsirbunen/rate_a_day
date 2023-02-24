import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/theme.dart';
import 'package:rate_a_day/packages/utils.dart' as utils;
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rxdart/rxdart.dart';

final IconData didLearnIcon =
    utils.Evaluations.getIcon(utils.Evaluation.didLearn);
final IconData didNotLearnIcon =
    utils.Evaluations.getIcon(utils.Evaluation.didNotLearn);
final Finder didLearnFinder = find.byIcon(didLearnIcon);
final Finder didNotLearnFinder = find.byIcon(didNotLearnIcon);
final Color learnColor = themeData.colorScheme.onTertiary;
final Color notSelectedColor = themeData.colorScheme.tertiaryContainer;

void main() {
  late DataBloc dataBloc;
  late ValueStream<bool> stream;

  _setUpOneTest(final WidgetTester tester) async {
    dataBloc = DataBloc();
    stream = dataBloc.didLearnNew;
    final Widget widget = BlocProvider(
      bloc: dataBloc,
      blocDisposer: (final DataBloc dataBloc) => dataBloc.dispose(),
      child: MaterialApp(
        theme: themeData,
        home: const Scaffold(
          body: Center(
            child: DidLearnToggle(),
          ),
        ),
      ),
    );

    await tester.pumpWidget(widget);
  }

  _tapIconThenVerifyColorAndLearning(
    final WidgetTester tester,
    final Finder finderStart,
    final Finder finderEnd,
    final bool didLearn,
    final Color color,
  ) async {
    Icon buttonIcon = tester.widget<Icon>(finderStart);
    await tester.tap(finderStart);
    await tester.pumpAndSettle();
    buttonIcon = tester.widget<Icon>(finderEnd);
    expect(buttonIcon.color, color);
    expect(stream, emits(didLearn));
  }

  testWidgets(
      'Tapping did learn icon changes icon color and emits true or false',
      (final WidgetTester tester) async {
    await _setUpOneTest(tester);

    Icon learnButton = tester.widget<Icon>(didNotLearnFinder);
    expect(learnButton.color, notSelectedColor);

    await _tapIconThenVerifyColorAndLearning(
        tester, didNotLearnFinder, didLearnFinder, true, learnColor);

    await _tapIconThenVerifyColorAndLearning(
        tester, didLearnFinder, didNotLearnFinder, false, notSelectedColor);

    await _tapIconThenVerifyColorAndLearning(
        tester, didNotLearnFinder, didLearnFinder, true, learnColor);

    await _tapIconThenVerifyColorAndLearning(
        tester, didLearnFinder, didNotLearnFinder, false, notSelectedColor);
  });
}
