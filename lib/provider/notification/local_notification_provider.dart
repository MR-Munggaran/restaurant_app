import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/service/local_notification_services.dart';
import 'package:restaurant_app/service/notification_preferences.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;
  final NotificationPreferences _notificationPreferences =
      NotificationPreferences();

  LocalNotificationProvider(this.flutterNotificationService) {
    // Inisialisasi status notifikasi dari shared preferences saat provider dibuat
    _loadNotificationStatus();
  }

  static const int _fixedNotificationId = 1;
  bool? _permission = false;
  bool? get permission => _permission;

  bool _isNotificationSet = false;
  bool get isNotificationSet => _isNotificationSet;

  List<PendingNotificationRequest> pendingNotificationRequests = [];

  Future _loadNotificationStatus() async {
    // Ambil daftar notifikasi yang tersimpan
    final savedNotifications =
        await _notificationPreferences.getNotifications();

    // Cek apakah ada notifikasi yang sudah diset
    _isNotificationSet = savedNotifications
        .any((notification) => notification.isNotificationSet == true);

    notifyListeners();
  }

  Future<void> requestPermissions() async {
    _permission = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }

  void toggleDailyNotification() async {
    if (_isNotificationSet) {
      // Jika notifikasi sudah aktif, maka batalkan
      await flutterNotificationService.cancelNotification(_fixedNotificationId);
      _isNotificationSet = false;
    } else {
      // Jika notifikasi belum aktif, maka jadwalkan
      await flutterNotificationService.scheduleDailyElevenAMNotification(
        id: _fixedNotificationId,
      );
      _isNotificationSet = true;
    }
    notifyListeners();
  }

  Future<void> checkPendingNotificationRequests(BuildContext context) async {
    pendingNotificationRequests =
        await flutterNotificationService.pendingNotificationRequests();
    notifyListeners();
  }
}
