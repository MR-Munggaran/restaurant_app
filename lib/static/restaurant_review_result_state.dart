import '../data/model/endpoint/restaurant_review.dart';

sealed class RestaurantReviewResultState {}

class RestaurantReviewNoneState extends RestaurantReviewResultState {}

class RestaurantReviewLoadingState extends RestaurantReviewResultState {}

class RestaurantReviewErrorState extends RestaurantReviewResultState {
  final String error;

  RestaurantReviewErrorState(this.error);
  String get userFriendlyError {
    if (error.contains('Failed to load Restaurant Detail')) {
      return 'Gagal memuat detail restoran. Silakan coba lagi nanti.';
    } else if (error.contains('No Internet')) {
      return 'Tidak ada koneksi internet. Silakan periksa koneksi Anda.';
    } else if (error.contains('Server error')) {
      return 'Terjadi masalah pada server. Harap coba lagi beberapa saat.';
    } else {
      return 'Terjadi kesalahan. Silakan coba lagi.';
    }
  }
}

class RestaurantReviewLoadedState extends RestaurantReviewResultState {
  final List<CustomerReview> customerReviews;

  RestaurantReviewLoadedState(this.customerReviews);
}
