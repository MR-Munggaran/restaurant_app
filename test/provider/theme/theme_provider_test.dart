import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/model/endpoint/thememode.dart';
import 'package:restaurant_app/provider/theme/theme_provider.dart';
import 'package:restaurant_app/service/theme_service.dart';

class MockThemeService extends Mock implements ThemeService {}

class FakeThemeModel extends Fake implements ThemeModel {}

void main() {
  late MockThemeService mockThemeService;
  late ThemeProvider themeProvider;

  setUpAll(() {
    registerFallbackValue(FakeThemeModel());
  });

  setUp(() {
    mockThemeService = MockThemeService();

    // Mock nilai default dari getTheme()
    when(() => mockThemeService.getTheme())
        .thenAnswer((_) async => ThemeModel(themeMode: 'light'));

    themeProvider = ThemeProvider(themeService: mockThemeService);
  });

  test('should initialize with light mode by default', () async {
    await themeProvider.loadTheme();
    expect(themeProvider.themeMode, ThemeMode.light);
  });

  test('should toggle theme mode from light to dark', () {
    when(() => mockThemeService.saveTheme(any())).thenAnswer((_) async {});

    themeProvider.toggleTheme(); // Tidak pakai await karena bukan Future

    expect(themeProvider.themeMode, ThemeMode.dark);
    verify(() => mockThemeService.saveTheme(any())).called(1);
  });

  test('should toggle theme mode from dark to light', () {
    when(() => mockThemeService.saveTheme(any())).thenAnswer((_) async {});

    themeProvider.toggleTheme(); // To dark
    themeProvider.toggleTheme(); // Back to light

    expect(themeProvider.themeMode, ThemeMode.light);
    verify(() => mockThemeService.saveTheme(any())).called(2);
  });

  test('should load theme from preferences', () async {
    when(() => mockThemeService.getTheme())
        .thenAnswer((_) async => ThemeModel(themeMode: 'dark'));

    await themeProvider.loadTheme(); // Load ulang theme

    expect(themeProvider.themeMode, ThemeMode.dark);
  });
}
