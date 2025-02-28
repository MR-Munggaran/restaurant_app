import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/endpoint/restaurant_detail.dart';
import 'package:restaurant_app/data/model/endpoint/restaurant_review.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';

void main() {
  group('RestaurantDetailResultState', () {
    test(
        'should be a subtype of RestaurantDetailResultState when RestaurantDetailNoneState is created',
        () {
      expect(RestaurantDetailNoneState(), isA<RestaurantDetailResultState>());
    });

    test(
        'should be a subtype of RestaurantDetailResultState when RestaurantDetailLoadingState is created',
        () {
      expect(
          RestaurantDetailLoadingState(), isA<RestaurantDetailResultState>());
    });

    group('RestaurantDetailErrorState', () {
      test(
          'should return "Gagal memuat detail restoran" when error contains "Failed to load Restaurant Detail"',
          () {
        const errorMessage = 'Failed to load Restaurant Detail';
        final errorState = RestaurantDetailErrorState(errorMessage);

        expect(errorState.userFriendlyError,
            'Gagal memuat detail restoran. Silakan coba lagi nanti.');
      });

      test(
          'should return "Tidak ada koneksi internet" when error contains "No Internet"',
          () {
        const errorMessage = 'No Internet';
        final errorState = RestaurantDetailErrorState(errorMessage);

        expect(errorState.userFriendlyError,
            'Tidak ada koneksi internet. Silakan periksa koneksi Anda.');
      });

      test(
          'should return "Terjadi masalah pada server" when error contains "Server error"',
          () {
        const errorMessage = 'Server error';
        final errorState = RestaurantDetailErrorState(errorMessage);

        expect(errorState.userFriendlyError,
            'Terjadi masalah pada server. Harap coba lagi beberapa saat.');
      });

      test('should return "Terjadi kesalahan" when error is unknown', () {
        const errorMessage = 'Unknown error';
        final errorState = RestaurantDetailErrorState(errorMessage);

        expect(errorState.userFriendlyError,
            'Terjadi kesalahan. Silakan coba lagi.');
      });
    });

    group('RestaurantDetailLoadedState', () {
      test(
          'should contain correct restaurant detail data when RestaurantDetailLoadedState is created',
          () {
        // Data mock
        final mockRestaurantDetail = RestaurantDetail(
          id: "rqdv5juczeskfw1e867",
          name: "Melting Pot",
          description:
              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
          city: "Medan",
          address: "Jln. Pandeglang no 19",
          pictureId: "14",
          rating: 4.2,
          categories: [
            Category(name: "Italia"),
            Category(name: "Modern"),
          ],
          menus: Menus(
            foods: [
              Food(name: "Paket rosemary"),
              Food(name: "Toastie salmon"),
            ],
            drinks: [
              Drink(name: "Es krim"),
              Drink(name: "Sirup"),
            ],
          ),
          customerReviews: [
            CustomerReview(
              name: "Ahmad",
              review: "Tidak rekomendasi untuk pelajar!",
              date: "13 November 2019",
            ),
          ],
        );

        // Buat state dengan data mock
        final loadedState = RestaurantDetailLoadedState(mockRestaurantDetail);

        // Verifikasi data
        expect(loadedState.data, mockRestaurantDetail);
        expect(loadedState.data.id, "rqdv5juczeskfw1e867");
        expect(loadedState.data.name, "Melting Pot");
        expect(loadedState.data.city, "Medan");
        expect(loadedState.data.rating, 4.2);
        expect(loadedState.data.categories.length, 2);
        expect(loadedState.data.categories[0].name, "Italia");
        expect(loadedState.data.categories[1].name, "Modern");
        expect(loadedState.data.menus.foods.length, 2);
        expect(loadedState.data.menus.foods[0].name, "Paket rosemary");
        expect(loadedState.data.menus.foods[1].name, "Toastie salmon");
        expect(loadedState.data.menus.drinks.length, 2);
        expect(loadedState.data.menus.drinks[0].name, "Es krim");
        expect(loadedState.data.menus.drinks[1].name, "Sirup");
        expect(loadedState.data.customerReviews.length,
            1); // Verifikasi customerReviews
        expect(loadedState.data.customerReviews[0].name, "Ahmad");
        expect(loadedState.data.customerReviews[0].review,
            "Tidak rekomendasi untuk pelajar!");
        expect(loadedState.data.customerReviews[0].date, "13 November 2019");
      });
    });
  });
}
