import 'dart:convert';

class ReceivedNotification {
  final int? id;
  final String? title;
  final String? body;

  ReceivedNotification({this.id, this.title, this.body});

  // Mengonversi objek ke format JSON
  String toJson() {
    final data = {
      'id': id,
      'title': title,
      'body': body,
    };
    return jsonEncode(data); // Gunakan jsonEncode, bukan toString
  }

  // Mengonversi JSON kembali ke objek ReceivedNotification
  factory ReceivedNotification.fromJson(String jsonString) {
    final Map<String, dynamic> data = json.decode(jsonString);
    return ReceivedNotification(
      id: data['id'],
      title: data['title'],
      body: data['body'],
    );
  }
}
