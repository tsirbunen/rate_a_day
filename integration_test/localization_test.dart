import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:rate_a_day/main.dart' as app;
import 'package:rate_a_day/packages/localizations.dart';
import 'helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App language can be changed', (final WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    verifyCorrectTranslation(tester, const Locale('en'), Phrase.settingsTitle);
    await openMenuAndTapTargetRouteButton(tester, Icons.settings_outlined);
    await changeLanguage(tester, const Locale('en'), const Locale('fi'));
    verifyCorrectTranslation(tester, const Locale('fi'), Phrase.settingsTitle);

    await openMenuAndTapTargetRouteButton(tester, Icons.today);
    verifyCorrectTranslation(tester, const Locale('fi'), Phrase.todayTitle);
    verifyCorrectTranslation(tester, const Locale('fi'), Phrase.todaySubtitle);

    await openMenuAndTapTargetRouteButton(tester, Icons.settings_outlined);
    await changeLanguage(tester, const Locale('fi'), const Locale('en'));
    verifyCorrectTranslation(tester, const Locale('en'), Phrase.settingsTitle);

    await openMenuAndTapTargetRouteButton(tester, Icons.today);
    verifyCorrectTranslation(tester, const Locale('en'), Phrase.todayTitle);
    verifyCorrectTranslation(tester, const Locale('en'), Phrase.todaySubtitle);
  });
}
