import 'dart:convert';

class NotificationResto {
  final int? id;
  final String? nameRestaurant;
  final String? rating;

  NotificationResto({this.id, this.nameRestaurant, this.rating});

  // Mengonversi objek ke format JSON
  String toJson() {
    final data = {
      'id': id,
      'nameRestaurant': nameRestaurant,
      'rating': rating,
    };
    return jsonEncode(data); // Gunakan jsonEncode, bukan toString
  }

  // Mengonversi JSON kembali ke objek NotificationResto
  factory NotificationResto.fromJson(String jsonString) {
    final Map<String, dynamic> data = json.decode(jsonString);
    return NotificationResto(
      id: data['id'],
      nameRestaurant: data['nameRestaurant'],
      rating: data['rating'],
    );
  }
}
