import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/endpoint/restaurant_search.dart';
import 'package:restaurant_app/static/restaurant_search_result_state.dart';

void main() {
  group('RestaurantSearchResultState', () {
    test(
        'should be a subtype of RestaurantSearchResultState when RestaurantSearchNoneState is created',
        () {
      expect(RestaurantSearchNoneState(), isA<RestaurantSearchResultState>());
    });

    test(
        'should be a subtype of RestaurantSearchResultState when RestaurantSearchLoadingState is created',
        () {
      expect(
          RestaurantSearchLoadingState(), isA<RestaurantSearchResultState>());
    });

    group('RestaurantSearchErrorState', () {
      test(
          'should return "Gagal memuat detail restoran" when error contains "Failed to load Restaurant Detail"',
          () {
        const errorMessage = 'Failed to load Restaurant Detail';
        final errorState = RestaurantSearchErrorState(errorMessage);

        expect(errorState.userFriendlyError,
            'Gagal memuat detail restoran. Silakan coba lagi nanti.');
      });

      test(
          'should return "Tidak ada koneksi internet" when error contains "No Internet"',
          () {
        const errorMessage = 'No Internet';
        final errorState = RestaurantSearchErrorState(errorMessage);

        expect(errorState.userFriendlyError,
            'Tidak ada koneksi internet. Silakan periksa koneksi Anda.');
      });

      test(
          'should return "Terjadi masalah pada server" when error contains "Server error"',
          () {
        const errorMessage = 'Server error';
        final errorState = RestaurantSearchErrorState(errorMessage);

        expect(errorState.userFriendlyError,
            'Terjadi masalah pada server. Harap coba lagi beberapa saat.');
      });

      test('should return "Terjadi kesalahan" when error is unknown', () {
        const errorMessage = 'Unknown error';
        final errorState = RestaurantSearchErrorState(errorMessage);

        expect(errorState.userFriendlyError,
            'Terjadi kesalahan. Silakan coba lagi.');
      });
    });

    group('RestaurantSearchLoadedState', () {
      test(
          'should contain a list of search restaurants when RestaurantSearchLoadedState is created',
          () {
        // Data mock
        final mockSearchRestaurants = [
          SearchRestaurant(
            id: "rqdv5juczeskfw1e867",
            name: "Melting Pot",
            description:
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
            city: "Medan",
            pictureId: "14",
            rating: 4.2,
          ),
          SearchRestaurant(
            id: "s1knt6za9kkfw1e867",
            name: "Kafe Kita",
            description:
                "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
            city: "Gorontalo",
            pictureId: "25",
            rating: 4,
          ),
        ];

        // Buat state dengan data mock
        final loadedState = RestaurantSearchLoadedState(mockSearchRestaurants);

        // Verifikasi data
        expect(loadedState.data, mockSearchRestaurants);
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
