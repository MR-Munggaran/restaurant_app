import 'package:restaurant_app/data/model/endpoint/reminder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPreferences {
  // Fungsi pembantu untuk mendapatkan list notifikasi dari SharedPreferences
  Future<List<String>> _getNotificationList() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('notifications') ?? [];
  }

  // Menyimpan notifikasi ke SharedPreferences
  Future<void> saveNotification(ReceivedNotification notification) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> notifications = await _getNotificationList();

      // Cari indeks notifikasi dengan ID yang sama
      int existingIndex = notifications.indexWhere(
          (json) => ReceivedNotification.fromJson(json).id == notification.id);

      if (existingIndex != -1) {
        // Jika notifikasi dengan ID sudah ada, ganti dengan data baru
        notifications[existingIndex] = notification.toJson();
      } else {
        // Jika tidak ada, tambahkan notifikasi baru
        notifications.add(notification.toJson());
      }

      // Simpan kembali seluruh daftar notifikasi
      await prefs.setStringList('notifications', notifications);
    } catch (e) {
      // Menangani error (misalnya log atau menampilkan pesan ke pengguna)
      print("Error saat menyimpan notifikasi: $e");
    }
  }

  // Mengambil semua notifikasi yang disimpan
  Future<List<ReceivedNotification>> getNotifications() async {
    try {
      List<String> notificationsJson = await _getNotificationList();

      // Mengonversi list string JSON menjadi objek ReceivedNotification
      return notificationsJson
          .map((json) => ReceivedNotification.fromJson(json))
          .toList();
    } catch (e) {
      // Menangani error (misalnya log atau menampilkan pesan ke pengguna)
      print("Error saat mengambil notifikasi: $e");
      return [];
    }
  }

  // Menghapus notifikasi berdasarkan ID
  Future<void> deleteNotification(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> notifications = await _getNotificationList();

      // Menghapus notifikasi berdasarkan ID
      notifications
          .removeWhere((json) => ReceivedNotification.fromJson(json).id == id);

      // Menyimpan list yang sudah diperbarui
      await prefs.setStringList('notifications', notifications);
    } catch (e) {
      // Menangani error (misalnya log atau menampilkan pesan ke pengguna)
      print("Error saat menghapus notifikasi: $e");
    }
  }
}
