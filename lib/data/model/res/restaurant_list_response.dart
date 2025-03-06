import '../endpoint/restaurant.dart';

class RestaurantListResponse {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  RestaurantListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantListResponse(
      error: json["error"] ?? false, // Default value if null
      message: json["message"] ?? "", // Default value if null
      count: json["count"] ?? 0, // Default value if null
      restaurants: json["restaurants"] != null // Check for null
          ? List<Restaurant>.from(
              json["restaurants"]!.map((x) => Restaurant.fromJson(x)))
          : <Restaurant>[], // Return empty list if null
    );
  }
}
