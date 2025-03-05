import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:restaurant_app/main.dart' as app;
import 'robot/navigation_robot.dart'; // Import NavigationRobot

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Navigation Test with Robot Pattern', () {
    testWidgets('Navigate from HomeScreen to DetailScreen and back',
        (WidgetTester tester) async {
      // Jalankan aplikasi
      app.main();

      // Tunggu hingga MainScreen muncul
      await tester.pumpAndSettle();

      // Buat instance NavigationRobot
      final navigationRobot = NavigationRobot(tester);

      // Verifikasi bahwa HomeScreen muncul
      await navigationRobot.verifyHomeScreenIsVisible();

      // Navigasi ke DetailScreen
      await navigationRobot.navigateToDetailScreen();

      // Kembali ke HomeScreen
      await navigationRobot.returnFromDetailScreen();
    });

    testWidgets('Navigate from HomeScreen to SettingScreen and back',
        (WidgetTester tester) async {
      // Jalankan aplikasi
      app.main();

      // Tunggu hingga MainScreen muncul
      await tester.pumpAndSettle();

      // Buat instance NavigationRobot
      final navigationRobot = NavigationRobot(tester);

      // Verifikasi bahwa HomeScreen muncul
      await navigationRobot.verifyHomeScreenIsVisible();

      // Navigasi ke SettingScreen
      await navigationRobot.navigateToSettingScreen();

      // Kembali ke HomeScreen
      await navigationRobot.returnFromSettingScreen();
    });

    testWidgets('Navigate from HomeScreen to SearchScreen and back',
        (WidgetTester tester) async {
      // Jalankan aplikasi
      app.main();

      // Tunggu hingga MainScreen muncul
      await tester.pumpAndSettle();

      // Buat instance NavigationRobot
      final navigationRobot = NavigationRobot(tester);

      // Verifikasi bahwa HomeScreen muncul
      await navigationRobot.verifyHomeScreenIsVisible();

      // Navigasi ke SearchScreen
      await navigationRobot.navigateToSearchScreen();

      // Kembali ke HomeScreen
      await navigationRobot.returnToHomeScreen();
    });

    testWidgets('Navigate from HomeScreen to FavoriteScreen and back',
        (WidgetTester tester) async {
      // Jalankan aplikasi
      app.main();

      // Tunggu hingga MainScreen muncul
      await tester.pumpAndSettle();

      // Buat instance NavigationRobot
      final navigationRobot = NavigationRobot(tester);

      // Verifikasi bahwa HomeScreen muncul
      await navigationRobot.verifyHomeScreenIsVisible();

      // Navigasi ke FavoriteScreen
      await navigationRobot.navigateToFavoriteScreen();

      // Kembali ke HomeScreen
      await navigationRobot.returnToHomeScreen();
    });
  });
}
