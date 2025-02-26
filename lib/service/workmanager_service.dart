import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/workmanager.dart';
import 'package:workmanager/workmanager.dart';
import 'package:restaurant_app/service/local_notification_services.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == MyWorkmanager.periodic.taskName) {
      final httpService = ApiServices();
      try {
        final restaurantData = await httpService.getRandomRestaurant();
        final flutterNotificationService = LocalNotificationService();

        await flutterNotificationService.init();

        int notificationId = 0;
        String restaurantName = restaurantData.name;
        String restaurantRate = restaurantData.rating.toString();

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
      : _workmanager = workmanager ??= Workmanager();
  bool get isTaskRunning => _isTaskRunning;

  Future<void> init() async {
    await _workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  }

  Future<void> runPeriodicTask() async {
    await _workmanager.registerPeriodicTask(
      MyWorkmanager.periodic.uniqueName,
      MyWorkmanager.periodic.taskName,
      frequency: const Duration(minutes: 10),
      initialDelay: Duration.zero,
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
