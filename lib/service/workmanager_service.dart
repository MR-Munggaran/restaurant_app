import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/workmanager.dart';
import 'package:workmanager/workmanager.dart';
import 'package:restaurant_app/service/local_notification_services.dart';
import 'package:http/http.dart' as http;

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == MyWorkmanager.periodic.taskName) {
      final httpClient = http.Client();
      final httpService = ApiServices(client: httpClient);
      try {
        final restaurantData = await httpService.getRandomRestaurant();
        final flutterNotificationService = LocalNotificationService();

        await flutterNotificationService.init();

        int notificationId = 0;
        String restaurantName = restaurantData.name ??
            "Unknown Restaurant"; // Fallback for null name
        String restaurantRate =
            restaurantData.rating?.toString() ?? "No Rating";

        await flutterNotificationService.showNotification(
          id: notificationId += 1,
          resto: restaurantName,
          rate: restaurantRate,
        );
      } catch (e) {
        print("Error fetching restaurant data: $e");
      }
    }
    return Future.value(true);
  });
}

class WorkmanagerService with ChangeNotifier {
  final Workmanager _workmanager;
  bool _isTaskRunning = false;

  WorkmanagerService([Workmanager? workmanager])
      : _workmanager = workmanager ?? Workmanager();

  bool get isTaskRunning => _isTaskRunning;

  Future<void> init() async {
    await _workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  }

  Future<void> runPeriodicTask() async {
    // Waktu target (11:00 AM)
    final now = DateTime.now();
    final targetTime = DateTime(now.year, now.month, now.day, 11, 0);

    // Hitung initialDelay
    Duration initialDelay;
    if (now.isBefore(targetTime)) {
      // Jika waktu saat ini sebelum pukul 11:00 AM hari ini
      initialDelay = targetTime.difference(now);
    } else {
      // Jika waktu saat ini setelah pukul 11:00 AM hari ini, set untuk besok
      initialDelay = targetTime.add(Duration(days: 1)).difference(now);
    }

    // Register periodic task
    await _workmanager.registerPeriodicTask(
      MyWorkmanager.periodic.uniqueName,
      MyWorkmanager.periodic.taskName,
      frequency: const Duration(hours: 24), // Set frequency ke 24 jam (1 hari)
      initialDelay: initialDelay,
      inputData: {
        "data": "This is a valid payload from periodic task workmanager",
      },
    );

    _isTaskRunning = true;
    notifyListeners();
  }

  Future<void> cancelAllTask() async {
    await _workmanager.cancelAll();
    _isTaskRunning = false;
    notifyListeners();
  }
}
