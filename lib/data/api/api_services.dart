import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/res/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/res/restaurant_search_response.dart';
import 'package:restaurant_app/data/model/res/restaurant_review_response.dart';
import '../model/res/restaurant_list_response.dart';

class ApiServices {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestaurantListResponse> getRestaurantList() async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/list"));

      if (response.statusCode == 200) {
        return RestaurantListResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        throw Exception('Daftar restoran tidak ditemukan.');
      } else {
        throw Exception('Gagal memuat Daftar Restoran. Server error.');
      }
    } catch (e) {
      if (e is http.ClientException) {
        throw Exception(
            'Kesalahan jaringan: Silakan periksa koneksi internet Anda.');
      } else {
        throw Exception('Terjadi kesalahan: $e');
      }
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

      if (response.statusCode == 200) {
        return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        throw Exception('Detail restoran tidak ditemukan.');
      } else {
        throw Exception('Gagal memuat Detail Restoran. Server error.');
      }
    } catch (e) {
      if (e is http.ClientException) {
        throw Exception(
            'Kesalahan jaringan: Silakan periksa koneksi internet Anda.');
      } else {
        throw Exception('Terjadi kesalahan: $e');
      }
    }
  }

  Future<SearchRestaurantResponse> searchRestaurant(String query) async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));

      if (response.statusCode == 200) {
        return SearchRestaurantResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        throw Exception('Restoran dengan kata kunci "$query" tidak ditemukan.');
      } else {
        throw Exception('Gagal mencari restoran. Server error.');
      }
    } catch (e) {
      if (e is http.ClientException) {
        throw Exception(
            'Kesalahan jaringan: Silakan periksa koneksi internet Anda.');
      } else {
        throw Exception('Terjadi kesalahan: $e');
      }
    }
  }

  Future<ReviewResponse> postReview({
    required String restaurantId,
    required String name,
    required String review,
  }) async {
    final url = Uri.parse("$_baseUrl/review");

    try {
      final response = await http.post(
        url,
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
        return ReviewResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Gagal mengirim review. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is http.ClientException) {
        throw Exception(
            'Kesalahan jaringan: Silakan periksa koneksi internet Anda.');
      } else {
        throw Exception('Terjadi kesalahan saat mengirim review: $e');
      }
    }
  }
}
