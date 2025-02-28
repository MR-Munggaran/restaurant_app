import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restaurant_app/data/model/endpoint/thememode.dart';
import 'package:restaurant_app/service/theme_service.dart';

void main() {
  late ThemeService themeService;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    themeService = ThemeService();
  });

  test('saveTheme should store theme mode in SharedPreferences', () async {
    final themeModel = ThemeModel(themeMode: 'dark');
    await themeService.saveTheme(themeModel);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('theme_mode'), 'dark');
  });

  test('getTheme should return stored theme mode', () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', 'dark');

    final themeModel = await themeService.getTheme();
    expect(themeModel.themeMode, 'dark');
  });

  test('getTheme should return default theme mode if none is stored', () async {
    final themeModel = await themeService.getTheme();
    expect(themeModel.themeMode, 'light');
  });
}
