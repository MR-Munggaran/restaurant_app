class ThemeModel {
  final String themeMode;

  ThemeModel({required this.themeMode});

  // Untuk mengubah ke bentuk Map, agar bisa disimpan di shared preferences
  Map<String, dynamic> toMap() {
    return {'theme_mode': themeMode};
  }

  // Untuk membuat objek ThemeModel dari Map (ketika membaca dari shared preferences)
  factory ThemeModel.fromMap(Map<String, dynamic> map) {
    return ThemeModel(themeMode: map['theme_mode']);
  }
}
