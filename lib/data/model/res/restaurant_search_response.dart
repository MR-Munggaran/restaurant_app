import 'package:restaurant_app/data/model/endpoint/restaurant_search.dart';

class SearchRestaurantResponse {
  final bool error;
  final int founded; // Can be nullable if needed
  final List<SearchRestaurant> restaurants;

  SearchRestaurantResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchRestaurantResponse.fromJson(Map<String, dynamic> json) {
    return SearchRestaurantResponse(
      error: json['error'] ?? false, // Default value if null
      founded: json['founded'] ?? 0, // Default value if null
      restaurants: json['restaurants'] != null
          ? List<SearchRestaurant>.from(
              json['restaurants'].map((x) => SearchRestaurant.fromJson(x)))
          : [], // Return empty list if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "error": error,
      "founded": founded,
      "restaurants":
          restaurants.map((restaurant) => restaurant.toJson()).toList(),
    };
  }
}
