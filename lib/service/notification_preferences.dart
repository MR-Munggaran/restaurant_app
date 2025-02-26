import 'package:restaurant_app/data/model/endpoint/reminder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPreferences {
  // Simpan notifikasi ke SharedPreferences
  Future<void> saveNotification(ReceivedNotification notification) async {
    final prefs = await SharedPreferences.getInstance();

    // Convert notifikasi ke format yang bisa disimpan, misalnya ke JSON
    List<String> notifications = prefs.getStringList('notifications') ?? [];
    notifications
        .add(notification.toJson()); // Simpan notifikasi dalam format JSON
    await prefs.setStringList('notifications', notifications);
  }

  // Ambil semua notifikasi yang disimpan
  Future<List<ReceivedNotification>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notificationsJson = prefs.getStringList('notifications') ?? [];

    // Convert kembali dari JSON ke objek ReceivedNotification
    return notificationsJson
        .map((json) => ReceivedNotification.fromJson(json))
        .toList();
  }

  // Hapus notifikasi tertentu
  Future<void> deleteNotification(int id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notifications = prefs.getStringList('notifications') ?? [];

    // Filter notifikasi berdasarkan ID
    notifications
        .removeWhere((json) => ReceivedNotification.fromJson(json).id == id);
    await prefs.setStringList('notifications', notifications);
  }
}
