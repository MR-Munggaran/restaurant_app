import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:restaurant_app/data/model/endpoint/notification_resto.dart';
import 'package:restaurant_app/data/model/endpoint/reminder.dart';
import 'package:restaurant_app/service/notifresto_preferences.dart';
import 'package:restaurant_app/service/notification_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class LocalNotificationService {
  final NotificationPreferences _notificationPreferences =
      NotificationPreferences();
  final NotifrestoPreferences _notifrestoPreferences = NotifrestoPreferences();

  Future<void> init() async {
    const initializationSettingsAndroid = AndroidInitializationSettings(
      'app_icon',
    );
    final initializationSettingsDarwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<bool> _isAndroidPermissionGranted() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.areNotificationsEnabled() ??
        false;
  }

  Future<bool> _requestAndroidNotificationsPermission() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission() ??
        false;
  }

  Future<bool> _requestExactAlarmsPermission() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestExactAlarmsPermission() ??
        false;
  }

  Future<bool?> requestPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iOSImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      return await iOSImplementation?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      final notificationEnabled = await _isAndroidPermissionGranted();
      final requestAlarmEnabled = await _requestExactAlarmsPermission();
      if (!notificationEnabled) {
        final requestNotificationsPermission =
            await _requestAndroidNotificationsPermission();
        return requestNotificationsPermission && requestAlarmEnabled;
      }
      return notificationEnabled && requestAlarmEnabled;
    } else {
      return false;
    }
  }

  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    print("Local Timezone: $timeZoneName");
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  tz.TZDateTime _nextInstanceOfElevenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 11, 0);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> showNotification({
    required int id,
    required String resto,
    required String rate,
    String channelId = "1",
    String channelName = "Rekomendasi",
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.max,
      priority: Priority.high,
      sound: const RawResourceAndroidNotificationSound('ringtone'),
      icon: 'app_icon',
    );
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails(
      sound: 'ringtone.aiff',
      presentSound: true,
    );
    final notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      'Makan Di $resto?',
      'Kamu Mau makan Siang di $resto? Mereka punya rating ${rate.toString()}',
      notificationDetails,
    );

    final receivedNotification = NotificationResto(
      id: id,
      nameRestaurant: 'Makan Di $resto?',
      rating:
          'Kamu Mau makan Siang di $resto? Mereka punya rating ${rate.toString()}',
    );

    // Menyimpan ke SharedPreferences
    await _notifrestoPreferences.saveNotification(receivedNotification);
  }

  Future<void> scheduleDailyElevenAMNotification({
    required int id,
    String channelId = "3",
    String channelName = "Schedule Notification",
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.max,
      priority: Priority.high,
      sound: const RawResourceAndroidNotificationSound('ringtone'),
      icon: 'app_icon',
    );
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails(
      sound: 'ringtone.aiff',
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    final datetimeSchedule = _nextInstanceOfElevenAM();

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Waktunya Makan Siang',
      'Yuk Cek Resto yang hits sekarang!',
      datetimeSchedule,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    // Simpan ke SharedPreferences setelah notifikasi dijadwalkan
    final receivedNotification = ReceivedNotification(
      id: id,
      title: 'Waktunya Makan Siang',
      body: 'Yuk Cek Resto yang hits sekarang!',
      isNotificationSet: true, // Tandakan bahwa notifikasi telah dijadwalkan
    );

    // Menyimpan ke SharedPreferences
    await _notificationPreferences.saveNotification(receivedNotification);
  }

  Future<List<ReceivedNotification>> getSavedNotifications() async {
    return await _notificationPreferences.getNotifications();
  }

  Future<void> deleteSavedNotification(int id) async {
    await _notificationPreferences.deleteNotification(id);
  }

  Future<List<PendingNotificationRequest>> pendingNotificationRequests() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return pendingNotificationRequests;
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    // Update status notifikasi menjadi false
    final receivedNotification = ReceivedNotification(
      id: id,
      title: 'Waktunya Makan Siang',
      body: 'Yuk Cek Resto yang hits sekarang!',
      isNotificationSet: false, // Tandakan bahwa notifikasi telah dibatalkan
    );
    await _notificationPreferences.saveNotification(receivedNotification);
  }
}
