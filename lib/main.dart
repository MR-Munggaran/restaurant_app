import 'package:flutter/material.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/theme/restaurant_theme.dart';
import 'package:restaurant_app/widget/detail/detail_screen.dart';
import 'package:restaurant_app/widget/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: RestaurantTheme.lightTheme,
      darkTheme: RestaurantTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute:
          NavigationRoute.mainRoute.name, // Menggunakan enum untuk route awal
      routes: {
        NavigationRoute.mainRoute.name: (context) =>
            MainScreen(), // Menambahkan const untuk HomeScreen
        NavigationRoute.detailRoute.name: (context) =>
            DetailScreen(), // Menambahkan const untuk DetailScreen
      },
    );
  }
}
