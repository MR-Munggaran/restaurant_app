import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/provider/theme/theme_provider.dart';
import 'robot/navigation_robot.dart';
import 'robot/theme_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Navigasi antara layar utama, detail, dan pengaturan",
      (tester) async {
    final navigationRobot = NavigationRobot(tester);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const MyApp(),
      ),
    );

    await tester.pumpAndSettle();

    await navigationRobot.navigateToSettings();
    await navigationRobot.returnToHome();
  });

  testWidgets("Uji perubahan tema", (tester) async {
    final themeProvider = ThemeProvider();
    final themeRobot = ThemeRobot(tester);

    await tester.pumpWidget(
      ChangeNotifierProvider<ThemeProvider>.value(
        value: themeProvider,
        child: const MyApp(),
      ),
    );

    await tester.pumpAndSettle();

    await themeRobot.toggleTheme();
    expect(themeProvider.themeMode, ThemeMode.dark);

    await themeRobot.toggleTheme();
    expect(themeProvider.themeMode, ThemeMode.light);
  });
}
