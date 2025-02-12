import 'package:restaurant_app/data/model/endpoint/restaurant_detail.dart';

sealed class RestaurantDetailResultState {}

class RestaurantDetailNoneState extends RestaurantDetailResultState {}

class RestaurantDetailLoadingState extends RestaurantDetailResultState {}

class RestaurantDetailErrorState extends RestaurantDetailResultState {
  final String error;

  RestaurantDetailErrorState(this.error);

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

class RestaurantDetailLoadedState extends RestaurantDetailResultState {
  final RestaurantDetail data;

  RestaurantDetailLoadedState(this.data);
}
