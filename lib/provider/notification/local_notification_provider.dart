import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/service/local_notification_services.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;

  LocalNotificationProvider(this.flutterNotificationService);

  int _notificationId = 0;
  bool? _permission = false;
  bool? get permission => _permission;

  bool _isNotificationSet = false; // Properti untuk menandakan status toggle
  bool get isNotificationSet =>
      _isNotificationSet; // Getter untuk status toggle

  List<PendingNotificationRequest> pendingNotificationRequests = [];

  Future<void> requestPermissions() async {
    _permission = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }

  void scheduleDailyElevenAMNotification() {
    _notificationId += 1;
    flutterNotificationService.scheduleDailyElevenAMNotification(
      id: _notificationId,
    );
    _isNotificationSet = true;
    notifyListeners();
  }

  Future<void> checkPendingNotificationRequests(BuildContext context) async {
    pendingNotificationRequests =
        await flutterNotificationService.pendingNotificationRequests();
    notifyListeners();
  }

  Future<void> cancelNotification(int id) async {
    await flutterNotificationService.cancelNotification(id);
  }

  Future<void> deleteSavedNotification(int id) async {
    await flutterNotificationService.deleteSavedNotification(id);
    _isNotificationSet = false;
    notifyListeners();
  }
}
