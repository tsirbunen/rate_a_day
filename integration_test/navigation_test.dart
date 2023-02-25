import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:rate_a_day/main.dart' as app;
import 'package:rate_a_day/packages/localizations.dart';
import 'helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App launches with today page and each page can be navigated to',
      (final WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    verifyRoutePage(Phrase.todayTitle, Phrase.todaySubtitle);

    await openMenuAndTapTargetRouteButton(tester, Icons.calendar_month);
    verifyRoutePage(Phrase.monthTitle, Phrase.monthSubtitle);

    await openMenuAndTapTargetRouteButton(tester, Icons.settings_outlined);
    verifyRoutePage(Phrase.settingsTitle, null);

    await openMenuAndTapTargetRouteButton(tester, Icons.info_outline);
    verifyRoutePage(Phrase.infoTitle, Phrase.infoSubtitle);

    await openMenuAndTapTargetRouteButton(tester, Icons.today);
    verifyRoutePage(Phrase.todayTitle, Phrase.todaySubtitle);
  });
}
