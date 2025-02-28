import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';
import 'package:restaurant_app/data/model/endpoint/restaurant.dart';

void main() {
  group('RestaurantListResultState', () {
    test(
        'should be a subtype of RestaurantListResultState when RestaurantListNoneState is created',
        () {
      expect(RestaurantListNoneState(), isA<RestaurantListResultState>());
    });

    test(
        'should be a subtype of RestaurantListResultState when RestaurantListLoadingState is created',
        () {
      expect(RestaurantListLoadingState(), isA<RestaurantListResultState>());
    });

    group('RestaurantListErrorState', () {
      test(
          'should return "Gagal memuat detail restoran" when error contains "Failed to load Restaurant Detail"',
          () {
        const errorMessage = 'Failed to load Restaurant Detail';
        final errorState = RestaurantListErrorState(errorMessage);

        expect(errorState.userFriendlyError,
            'Gagal memuat detail restoran. Silakan coba lagi nanti.');
      });

      test(
          'should return "Tidak ada koneksi internet" when error contains "No Internet"',
          () {
        const errorMessage = 'No Internet';
        final errorState = RestaurantListErrorState(errorMessage);

        expect(errorState.userFriendlyError,
            'Tidak ada koneksi internet. Silakan periksa koneksi Anda.');
      });

      test(
          'should return "Terjadi masalah pada server" when error contains "Server error"',
          () {
        const errorMessage = 'Server error';
        final errorState = RestaurantListErrorState(errorMessage);

        expect(errorState.userFriendlyError,
            'Terjadi masalah pada server. Harap coba lagi beberapa saat.');
      });

      test('should return "Terjadi kesalahan" when error is unknown', () {
        const errorMessage = 'Unknown error';
        final errorState = RestaurantListErrorState(errorMessage);

        expect(errorState.userFriendlyError,
            'Terjadi kesalahan. Silakan coba lagi.');
      });
    });

    group('RestaurantListLoadedState', () {
      test(
          'should contain a list of restaurants with correct data when RestaurantListLoadedState is created',
          () {
        // Data mock
        final mockRestaurants = [
          Restaurant(
            id: "rqdv5juczeskfw1e867",
            name: "Melting Pot",
            description:
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
            pictureId: "14",
            city: "Medan",
            rating: 4.2,
          ),
          Restaurant(
            id: "s1knt6za9kkfw1e867",
            name: "Kafe Kita",
            description:
                "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
            pictureId: "25",
            city: "Gorontalo",
            rating: 4,
          ),
        ];

        // Buat state dengan data mock
        final loadedState = RestaurantListLoadedState(mockRestaurants);

        // Verifikasi data
        expect(loadedState.data, mockRestaurants);
        expect(loadedState.data.length, 2);

        // Verifikasi data pertama
        expect(loadedState.data[0].id, "rqdv5juczeskfw1e867");
        expect(loadedState.data[0].name, "Melting Pot");
        expect(loadedState.data[0].city, "Medan");
        expect(loadedState.data[0].rating, 4.2);

        // Verifikasi data kedua
        expect(loadedState.data[1].id, "s1knt6za9kkfw1e867");
        expect(loadedState.data[1].name, "Kafe Kita");
        expect(loadedState.data[1].city, "Gorontalo");
        expect(loadedState.data[1].rating, 4);
      });
    });
  });
}
