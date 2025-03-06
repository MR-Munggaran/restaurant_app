import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/endpoint/restaurant.dart';
import 'package:restaurant_app/data/model/res/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/res/restaurant_search_response.dart';
import 'package:restaurant_app/data/model/res/restaurant_review_response.dart';
import '../model/res/restaurant_list_response.dart';

class ApiServices {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  final http.Client client;

  // Constructor with named parameter 'client'
  ApiServices({required this.client});

  Future<RestaurantListResponse> getRestaurantList() async {
    try {
      final response = await client.get(Uri.parse("$_baseUrl/list"));

      if (response.statusCode == 200) {
        // Pastikan response body tidak null
        if (response.body.isEmpty) {
          throw Exception('Response body is empty.');
        }

        final jsonResponse = jsonDecode(response.body);
        return RestaurantListResponse.fromJson(jsonResponse);
      } else if (response.statusCode == 404) {
        throw Exception('Daftar restoran tidak ditemukan.');
      } else {
        throw Exception(
            'Gagal memuat daftar restoran. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Log the error
      print('Error fetching restaurant list: $e');
      throw Exception('Gagal memuat daftar restoran.');
    }
  }

  Future<Restaurant> getRandomRestaurant() async {
    try {
      final RestaurantListResponse restaurants = await getRestaurantList();

      if (restaurants.restaurants.isEmpty) {
        throw Exception("Tidak ada restoran tersedia.");
      }

      // Acak daftar restoran dan ambil yang pertama
      restaurants.restaurants.shuffle();
      return restaurants.restaurants.first;
    } catch (e) {
      // Log the error
      print('Error getting random restaurant: $e');
      throw Exception('Gagal mendapatkan restoran acak.');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    try {
      final response = await client.get(Uri.parse("$_baseUrl/detail/$id"));

      if (response.statusCode == 200) {
        // Pastikan response body tidak null
        if (response.body.isEmpty) {
          throw Exception('Response body is empty.');
        }

        final jsonResponse = jsonDecode(response.body);
        return RestaurantDetailResponse.fromJson(jsonResponse);
      } else if (response.statusCode == 404) {
        throw Exception('Detail restoran tidak ditemukan.');
      } else {
        throw Exception(
            'Gagal memuat detail restoran. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Log the error
      print('Error fetching restaurant detail: $e');
      throw Exception('Gagal memuat detail restoran.');
    }
  }

  Future<SearchRestaurantResponse> searchRestaurant(String query) async {
    try {
      final response = await client.get(Uri.parse("$_baseUrl/search?q=$query"));

      if (response.statusCode == 200) {
        // Pastikan response body tidak null
        if (response.body.isEmpty) {
          throw Exception('Response body is empty.');
        }

        final jsonResponse = jsonDecode(response.body);
        return SearchRestaurantResponse.fromJson(jsonResponse);
      } else if (response.statusCode == 404) {
        throw Exception('Hasil pencarian tidak ditemukan.');
      } else {
        throw Exception(
            'Gagal memuat hasil pencarian. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Log the error
      print('Error searching restaurant: $e');
      throw Exception('Gagal memuat hasil pencarian.');
    }
  }

  Future<ReviewResponse> postReview({
    required String restaurantId,
    required String name,
    required String review,
  }) async {
    try {
      final response = await client.post(
        Uri.parse("$_baseUrl/review"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "id": restaurantId,
          "name": name,
          "review": review,
        }),
      );

      if (response.statusCode == 201) {
        // Pastikan response body tidak null
        if (response.body.isEmpty) {
          throw Exception('Response body is empty.');
        }

        final jsonResponse = jsonDecode(response.body);
        return ReviewResponse.fromJson(jsonResponse);
      } else {
        throw Exception(
            'Gagal mengirim ulasan. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Log the error
      print('Error posting review: $e');
      throw Exception('Gagal mengirim ulasan.');
    }
  }
}
