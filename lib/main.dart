import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/service/local_notification_services.dart';
import 'package:restaurant_app/service/workmanager_service.dart';
import 'package:restaurant_app/data/sql/local_database_service.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/favorite/local_database_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/index_nav_provider.dart';
import 'package:restaurant_app/provider/notification/local_notification_provider.dart';
import 'package:restaurant_app/provider/review/restaurant_review_provider.dart';
import 'package:restaurant_app/provider/search/restaurant_search_provider.dart';
import 'package:restaurant_app/provider/theme/theme_provider.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/theme/restaurant_theme.dart';
import 'package:restaurant_app/widget/detail/detail_screen.dart';
import 'package:restaurant_app/widget/main_screen.dart';
import 'package:restaurant_app/widget/settings/setting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        // Services
        Provider(create: (context) => ApiServices()),
        Provider(
          create: (context) => LocalNotificationService()
            ..init()
            ..configureLocalTimeZone(),
        ),
        Provider(create: (context) => LocalDatabaseService()),

        // State Management Providers
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),

        // Restaurant Providers (Require ApiServices)
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantListProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantDetailProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantSearchProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantReviewProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              LocalDatabaseProvider(context.read<LocalDatabaseService>()),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => WorkmanagerService()..init(),
        // ),

        // Notification Providers
        ChangeNotifierProvider(
          create: (context) => LocalNotificationProvider(
            context.read<LocalNotificationService>(),
          )..requestPermissions(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          title: 'Restaurant App',
          theme: RestaurantTheme.lightTheme,
          darkTheme: RestaurantTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          initialRoute: NavigationRoute.mainRoute.name,
          routes: {
            NavigationRoute.mainRoute.name: (context) => MainScreen(),
            NavigationRoute.detailRoute.name: (context) => DetailScreen(
                  restId: ModalRoute.of(context)?.settings.arguments as String,
                ),
            NavigationRoute.settingRoute.name: (context) => SettingScreen(),
          },
        );
      },
    );
  }
}
