import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/restaurant_review_result_state.dart';

class RestaurantReviewProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantReviewProvider(this._apiServices);

  RestaurantReviewResultState _resultState = RestaurantReviewNoneState();

  RestaurantReviewResultState get resultState => _resultState;

  Future<void> postReview(
      String restaurantId, String name, String review) async {
    if (name.isEmpty || review.isEmpty) {
      _resultState =
          RestaurantReviewErrorState("Nama dan review tidak boleh kosong.");
      notifyListeners();
      return;
    }

    try {
      _resultState = RestaurantReviewLoadingState();
      notifyListeners();

      final response = await _apiServices.postReview(
        restaurantId: restaurantId,
        name: name,
        review: review,
      );

      _resultState = RestaurantReviewLoadedState(response.customerReviews);
      notifyListeners();
    } catch (e) {
      String userFriendlyMessage;

      if (e.toString().contains('Failed to load')) {
        userFriendlyMessage =
            'Gagal mengirim review restoran. Silakan coba lagi nanti.';
      } else if (e.toString().contains('No Internet')) {
        userFriendlyMessage =
            'Tidak ada koneksi internet. Periksa koneksi Anda dan coba lagi.';
      } else {
        userFriendlyMessage =
            'Terjadi kesalahan saat mengirim review restoran. Harap coba lagi.';
      }

      _resultState = RestaurantReviewErrorState(userFriendlyMessage);
      notifyListeners();
    }
  }
}
