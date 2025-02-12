import '../data/model/endpoint/restaurant_search.dart';

sealed class RestaurantSearchResultState {}

class RestaurantSearchNoneState extends RestaurantSearchResultState {}

class RestaurantSearchLoadingState extends RestaurantSearchResultState {}

class RestaurantSearchErrorState extends RestaurantSearchResultState {
  final String error;

  RestaurantSearchErrorState(this.error);
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

class RestaurantSearchLoadedState extends RestaurantSearchResultState {
  final List<SearchRestaurant> data;

  RestaurantSearchLoadedState(this.data);
}
