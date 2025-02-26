import 'package:restaurant_app/data/model/endpoint/thememode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const _themeKey = 'theme_mode';

  // Menyimpan tema
  Future<void> saveTheme(ThemeModel themeModel) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_themeKey, themeModel.themeMode);
  }

  // Membaca tema
  Future<ThemeModel> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeMode = prefs.getString(_themeKey) ??
        'light'; // Default ke 'light' jika tidak ada
    return ThemeModel(themeMode: themeMode);
  }
}
