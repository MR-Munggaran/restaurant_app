import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/index_nav_provider.dart';
import 'package:restaurant_app/provider/review/restaurant_review_provider.dart';
import 'package:restaurant_app/provider/search/restaurant_search_provider.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/theme/restaurant_theme.dart';
import 'package:restaurant_app/widget/detail/detail_screen.dart';
import 'package:restaurant_app/widget/main_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => IndexNavProvider(),
      ),
      Provider(create: (context) => ApiServices()),
      ChangeNotifierProvider(
        create: (context) => RestaurantListProvider(
          context.read<ApiServices>(),
        ),
      ),
      ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
                context.read<ApiServices>(),
              )),
      ChangeNotifierProvider(
        create: (context) =>
            RestaurantSearchProvider(context.read<ApiServices>()),
      ),
      ChangeNotifierProvider(
        create: (context) =>
            RestaurantReviewProvider(context.read<ApiServices>()),
      ),
    ],
    child: const MyApp(),
  ));
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
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
            restId: ModalRoute.of(context)?.settings.arguments
                as String), // Menambahkan const untuk DetailScreen
      },
    );
  }
}
