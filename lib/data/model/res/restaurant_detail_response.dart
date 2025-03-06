import '../endpoint/restaurant_detail.dart';

class RestaurantDetailResponse {
  final bool error;
  final String message;
  final RestaurantDetail restaurant;

  RestaurantDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailResponse(
      error: json["error"] ?? false, // Default to false if null
      message:
          json["message"] ?? 'No message available', // Default message if null
      restaurant: json["restaurant"] != null
          ? RestaurantDetail.fromJson(json["restaurant"])
          : RestaurantDetail(
              id: '',
              name: 'Unknown',
              description: 'No description available',
              city: 'Unknown City',
              address: 'No address available',
              pictureId: '',
              categories: [],
              menus: Menus(foods: [], drinks: []),
              rating: 0.0,
              customerReviews: [],
            ), // Default RestaurantDetail if null
    );
  }
}
