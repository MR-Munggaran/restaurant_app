import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/endpoint/thememode.dart';
import 'package:restaurant_app/service/theme_service.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  final ThemeService _themeService = ThemeService();

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadThemeFromPreferences();
  }

  // Mengubah tema
  void toggleTheme() async {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await _themeService.saveTheme(
        ThemeModel(themeMode: _themeMode == ThemeMode.dark ? 'dark' : 'light'));
    notifyListeners();
  }

  // Membaca tema dari penyimpanan
  Future<void> _loadThemeFromPreferences() async {
    ThemeModel themeModel = await _themeService.getTheme();
    _themeMode =
        themeModel.themeMode == 'dark' ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
