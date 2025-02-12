import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/restaurant_search_result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantSearchProvider(this._apiServices);

  RestaurantSearchResultState _resultState = RestaurantSearchNoneState();

  RestaurantSearchResultState get resultState => _resultState;

  Future<void> fetchSearchResult(String query) async {
    if (query.isEmpty) {
      _resultState = RestaurantSearchNoneState();
      notifyListeners();
      return;
    }

    try {
      _resultState = RestaurantSearchLoadingState();
      notifyListeners();

      final result = await _apiServices.searchRestaurant(query);

      if (result.error) {
        _resultState = RestaurantSearchErrorState("Failed to fetch results");
        notifyListeners();
      } else {
        _resultState = RestaurantSearchLoadedState(result.restaurants);
        notifyListeners();
      }
    } catch (e) {
      String userFriendlyMessage;
      if (e.toString().contains('Failed to load')) {
        userFriendlyMessage =
            'Gagal memuat Search restoran. Silakan coba lagi nanti.';
      } else if (e.toString().contains('No Internet')) {
        userFriendlyMessage =
            'Tidak ada koneksi internet. Periksa koneksi Anda dan coba lagi.';
      } else {
        userFriendlyMessage =
            'Terjadi kesalahan saat memuat Search restoran. Harap coba lagi.';
      }
      _resultState = RestaurantSearchErrorState(userFriendlyMessage);
      notifyListeners();
    }
  }
}
