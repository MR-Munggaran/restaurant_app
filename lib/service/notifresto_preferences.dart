import 'package:shared_preferences/shared_preferences.dart';
import 'package:restaurant_app/data/model/endpoint/notification_resto.dart';

class NotifrestoPreferences {
  // Simpan notifikasi ke SharedPreferences
  Future<void> saveNotification(NotificationResto notification) async {
    final prefs = await SharedPreferences.getInstance();

    // Convert notifikasi ke format yang bisa disimpan, misalnya ke JSON
    List<String> restoNotif = prefs.getStringList('restoNotif') ?? [];
    restoNotif.add(notification.toJson());
    await prefs.setStringList('restoNotif', restoNotif);
  }

  // Ambil semua notifikasi yang disimpan
  Future<List<NotificationResto>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notificationsJson = prefs.getStringList('restoNotif') ?? [];

    // Convert kembali dari JSON ke objek NotificationResto
    return notificationsJson
        .map((json) => NotificationResto.fromJson(json))
        .toList();
  }

  // Hapus notifikasi tertentu
  Future<void> deleteNotification(int id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> restoNotif = prefs.getStringList('restoNotif') ?? [];

    // Filter notifikasi berdasarkan ID
    restoNotif.removeWhere((json) => NotificationResto.fromJson(json).id == id);
    await prefs.setStringList('restoNotif', restoNotif);
  }
}
