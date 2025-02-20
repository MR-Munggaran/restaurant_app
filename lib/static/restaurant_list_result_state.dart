import '../data/model/endpoint/restaurant.dart';

sealed class RestaurantListResultState {}

class RestaurantListNoneState extends RestaurantListResultState {}

class RestaurantListLoadingState extends RestaurantListResultState {}

class RestaurantListErrorState extends RestaurantListResultState {
  final String error;

  RestaurantListErrorState(this.error);

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

class RestaurantListLoadedState extends RestaurantListResultState {
  final List<Restaurant> data;

  RestaurantListLoadedState(this.data);
}
