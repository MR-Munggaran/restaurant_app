import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/widget/favorite/favorite_screen.dart';
import 'package:restaurant_app/widget/home/home_screen.dart';
import 'package:restaurant_app/widget/home/home_widget.dart';
import 'package:restaurant_app/widget/search/search_screen.dart';
import 'package:restaurant_app/widget/settings/setting_screen.dart';
import 'package:restaurant_app/widget/detail/detail_screen.dart';

class NavigationRobot {
  final WidgetTester tester;

  NavigationRobot(this.tester);

  Future<void> verifyHomeScreenIsVisible() async {
    // Verifikasi bahwa HomeScreen muncul
    expect(find.byIcon(Icons.home), findsOneWidget,
        reason: "Home icon should be visible");
    expect(find.byType(HomeScreen), findsOneWidget,
        reason: "HomeScreen should be visible");
  }

  Future<void> navigateToSearchScreen() async {
    // Tap pada tombol Search di BottomNavigationBar
    final searchIcon = find.byIcon(Icons.search);
    expect(searchIcon, findsOneWidget, reason: "Search icon should be visible");

    await tester.tap(searchIcon);
    await tester.pumpAndSettle();

    // Verifikasi bahwa SearchScreen muncul
    expect(find.byType(SearchScreen), findsOneWidget,
        reason: "Should navigate to Search screen");
  }

  Future<void> navigateToFavoriteScreen() async {
    // Tap pada tombol Favorite di BottomNavigationBar
    final favoriteIcon = find.byIcon(Icons.favorite);
    expect(favoriteIcon, findsOneWidget,
        reason: "Favorite icon should be visible");

    await tester.tap(favoriteIcon);
    await tester.pumpAndSettle();

    // Verifikasi bahwa FavoriteScreen muncul
    expect(find.byType(FavoriteScreen), findsOneWidget,
        reason: "Should navigate to Favorite screen");
  }

  Future<void> navigateToSettingScreen() async {
    // Tap pada tombol Settings di AppBar (ikon Icons.settings)
    final settingsIcon = find.byIcon(Icons.settings);
    expect(settingsIcon, findsOneWidget,
        reason: "Settings icon should be visible");

    await tester.tap(settingsIcon);
    await tester.pumpAndSettle();

    // Verifikasi bahwa SettingScreen muncul
    expect(find.byType(SettingScreen), findsOneWidget,
        reason: "Should navigate to Setting screen");
  }

  Future<void> navigateToDetailScreen() async {
    await tester.pumpAndSettle(); // Pastikan semua widget sudah ter-render

    final firstRestaurantItem = find.byType(HomeWidget).first;

    // Pastikan elemen ditemukan
    expect(firstRestaurantItem, findsOneWidget,
        reason: "Item pertama restoran harus ada");

    // Tap pada item pertama
    await tester.tap(firstRestaurantItem);
    await tester.pumpAndSettle();

    // Pastikan navigasi berhasil
    expect(find.byType(DetailScreen), findsOneWidget,
        reason: "Harus pindah ke DetailScreen");
  }

  Future<void> returnToHomeScreen() async {
    // Tap pada tombol Home di BottomNavigationBar
    final homeIcon = find.byIcon(Icons.home);
    expect(homeIcon, findsOneWidget, reason: "Home icon should be visible");

    await tester.tap(homeIcon);
    await tester.pumpAndSettle();

    // Verifikasi bahwa HomeScreen muncul kembali
    expect(find.byType(HomeScreen), findsOneWidget,
        reason: "Should return to Home screen");
  }

  Future<void> returnFromSettingScreen() async {
    // Tap pada tombol back untuk kembali ke HomeScreen
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Verifikasi bahwa HomeScreen muncul kembali
    expect(find.byType(HomeScreen), findsOneWidget,
        reason: "Should return to Home screen from SettingScreen");
  }

  Future<void> returnFromDetailScreen() async {
    // Tap pada tombol back untuk kembali ke HomeScreen
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Verifikasi bahwa HomeScreen muncul kembali
    expect(find.byType(HomeScreen), findsOneWidget,
        reason: "Should return to Home screen from DetailScreen");
  }
}
