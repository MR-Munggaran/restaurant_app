import 'package:restaurant_app/data/model/endpoint/restaurant_search.dart';

class SearchRestaurantResponse {
  final bool error;
  final int founded;
  final List<SearchRestaurant> restaurants;

  SearchRestaurantResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchRestaurantResponse.fromJson(Map<String, dynamic> json) {
    return SearchRestaurantResponse(
      error: json['error'],
      founded: json['founded'],
      restaurants: List<SearchRestaurant>.from(
        json['restaurants'].map((x) => SearchRestaurant.fromJson(x)),
      ),
    );
  }
}
