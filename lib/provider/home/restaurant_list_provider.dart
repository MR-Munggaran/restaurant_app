import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantListProvider(
    this._apiServices,
  );

  RestaurantListResultState _resultState = RestaurantListNoneState();

  RestaurantListResultState get resultState => _resultState;

  Future<void> fetchRestaurantList() async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantList();

      if (result.error) {
        _resultState = RestaurantListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantListLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (e) {
      String userFriendlyMessage;
      if (e.toString().contains('Failed to load')) {
        userFriendlyMessage =
            'Gagal memuat list restoran. Silakan coba lagi nanti.';
      } else if (e.toString().contains('No Internet')) {
        userFriendlyMessage =
            'Tidak ada koneksi internet. Periksa koneksi Anda dan coba lagi.';
      } else {
        userFriendlyMessage =
            'Terjadi kesalahan saat memuat list restoran. Harap coba lagi.';
      }
      _resultState = RestaurantListErrorState(userFriendlyMessage);
      notifyListeners();
    }
  }
}
