import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantDetailProvider(this._apiServices);

  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();

  RestaurantDetailResultState get resultState => _resultState;

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _resultState = RestaurantDetailLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantDetail(id);

      if (result.error) {
        _resultState = RestaurantDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantDetailLoadedState(result.restaurant);
        notifyListeners();
      }
    } on Exception catch (e) {
      // Tangkap exception dan konversikan ke pesan error yang lebih ramah
      String userFriendlyMessage;
      if (e.toString().contains('Failed to load')) {
        userFriendlyMessage =
            'Gagal memuat detail restoran. Silakan coba lagi nanti.';
      } else if (e.toString().contains('No Internet')) {
        userFriendlyMessage =
            'Tidak ada koneksi internet. Periksa koneksi Anda dan coba lagi.';
      } else {
        userFriendlyMessage =
            'Terjadi kesalahan saat memuat detail restoran. Harap coba lagi.';
      }

      _resultState = RestaurantDetailErrorState(userFriendlyMessage);
      notifyListeners();
    }
  }
}
