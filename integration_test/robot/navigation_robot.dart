import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

class NavigationRobot {
  final WidgetTester tester;

  NavigationRobot(this.tester);

  Future<void> navigateToSettings() async {
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();
    expect(find.text("Settings"), findsOneWidget);
  }

  Future<void> returnToHome() async {
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byType(Scaffold), findsOneWidget);
  }
}
