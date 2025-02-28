import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/api/api_services.dart';

void main() {
  group('ApiServices', () {
    late ApiServices apiServices;

    setUp(() {
      apiServices = ApiServices();
    });

    test('should return RestaurantListResponse when response code is 200',
        () async {
      final uri = Uri.parse("https://restaurant-api.dicoding.dev/list");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final result = await apiServices.getRestaurantList();
        expect(result.restaurants, isNotEmpty);
        expect(result.restaurants.first.name, "Melting Pot");
      } else {
        fail("Failed to fetch data");
      }
    });

    test('should throw Exception when response code is 404', () async {
      final uri = Uri.parse("https://restaurant-api.dicoding.dev/list");
      final response = await http.get(uri);

      if (response.statusCode == 404) {
        expect(
            () => apiServices.getRestaurantList(),
            throwsA(isA<Exception>().having((e) => e.toString(), 'message',
                contains('Daftar restoran tidak ditemukan.'))));
      }
    });

    test('should throw Exception when response is a server error', () async {
      final uri = Uri.parse("https://restaurant-api.dicoding.dev/list");
      final response = await http.get(uri);

      if (response.statusCode == 500) {
        expect(
            () => apiServices.getRestaurantList(),
            throwsA(isA<Exception>().having((e) => e.toString(), 'message',
                contains('Gagal memuat Daftar Restoran. Server error.'))));
      }
    });

    test('should return RestaurantDetailResponse when response code is 200',
        () async {
      final uri = Uri.parse(
          "https://restaurant-api.dicoding.dev/detail/rqdv5juczeskfw1e867");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final result =
            await apiServices.getRestaurantDetail("rqdv5juczeskfw1e867");
        expect(result.restaurant.name, "Melting Pot");
      } else {
        fail("Failed to fetch restaurant detail");
      }
    });

    test('should return SearchRestaurantResponse when response code is 200',
        () async {
      final uri = Uri.parse(
          "https://restaurant-api.dicoding.dev/search?q=Melting%20Pot");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final result = await apiServices.searchRestaurant("Melting Pot");
        expect(result.restaurants.first.name, "Melting Pot");
      } else {
        fail("Failed to fetch search results");
      }
    });

    test('should return ReviewResponse when posting a review successfully',
        () async {
      final uri = Uri.parse("https://restaurant-api.dicoding.dev/review");
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "id": "rqdv5juczeskfw1e867",
          "name": "John Doe",
          "review": "Great food!"
        }),
      );

      if (response.statusCode == 201) {
        final result = await apiServices.postReview(
          restaurantId: "rqdv5juczeskfw1e867",
          name: "John Doe",
          review: "Great food!",
        );
        expect(result.message, "success");
      } else {
        fail("Failed to post review");
      }
    });
  });
}
