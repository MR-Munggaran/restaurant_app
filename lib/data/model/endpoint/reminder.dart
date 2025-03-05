import 'dart:convert';

class ReceivedNotification {
  final int? id;
  final String? title;
  final String? body;
  final bool
      isNotificationSet; // Menambahkan status apakah notifikasi telah dijadwalkan

  ReceivedNotification({
    this.id,
    this.title,
    this.body,
    this.isNotificationSet = false, // Default false
  });

  // Mengonversi objek ke format JSON
  String toJson() {
    final data = {
      'id': id,
      'title': title,
      'body': body,
      'isNotificationSet': isNotificationSet, // Menyimpan status notifikasi
    };
    return jsonEncode(data);
  }

  // Mengonversi JSON kembali ke objek ReceivedNotification
  factory ReceivedNotification.fromJson(String jsonString) {
    final Map<String, dynamic> data = json.decode(jsonString);
    return ReceivedNotification(
      id: data['id'],
      title: data['title'],
      body: data['body'],
      isNotificationSet:
          data['isNotificationSet'] ?? false, // Membaca status dari JSON
    );
  }
}
