import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:rate_a_day/main.dart' as app;
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Routing', () {
    testWidgets('Navigation menu can be tapped open and each page navigated to',
        (tester) async {
      final Translator translator = Translator(Language.EN);

      app.main();
      await tester.pumpAndSettle();
      final String todayText = translator.get(Phrase.routeToday);
      expect(find.text(todayText), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.calendar_month));
      await tester.pumpAndSettle();
      final String calendar = translator.get(Phrase.routeMonth);
      expect(find.text(calendar), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.info_outline));
      await tester.pumpAndSettle();
      final String info = translator.get(Phrase.routeInfo);
      expect(find.text(info), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();
      final String settings = translator.get(Phrase.routeSettings);
      expect(find.text(settings), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.today));
      await tester.pumpAndSettle();
      final String today = translator.get(Phrase.routeToday);
      expect(find.text(today), findsOneWidget);
    });
  });
}
