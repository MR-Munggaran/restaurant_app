import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/endpoint/restaurant_review.dart';
import 'package:restaurant_app/static/restaurant_review_result_state.dart';

void main() {
  group('RestaurantReviewResultState', () {
    test(
        'should be a subtype of RestaurantReviewResultState when RestaurantReviewNoneState is created',
        () {
      expect(RestaurantReviewNoneState(), isA<RestaurantReviewResultState>());
    });

    test(
        'should be a subtype of RestaurantReviewResultState when RestaurantReviewLoadingState is created',
        () {
      expect(
          RestaurantReviewLoadingState(), isA<RestaurantReviewResultState>());
    });

    group('RestaurantReviewErrorState', () {
      test(
          'should return "Gagal memuat detail restoran" when error contains "Failed to load Restaurant Detail"',
          () {
        const errorMessage = 'Failed to load Restaurant Detail';
        final errorState = RestaurantReviewErrorState(errorMessage);

        expect(errorState.userFriendlyError,
            'Gagal memuat detail restoran. Silakan coba lagi nanti.');
      });

      test(
          'should return "Tidak ada koneksi internet" when error contains "No Internet"',
          () {
        const errorMessage = 'No Internet';
        final errorState = RestaurantReviewErrorState(errorMessage);

        expect(errorState.userFriendlyError,
            'Tidak ada koneksi internet. Silakan periksa koneksi Anda.');
      });

      test(
          'should return "Terjadi masalah pada server" when error contains "Server error"',
          () {
        const errorMessage = 'Server error';
        final errorState = RestaurantReviewErrorState(errorMessage);

        expect(errorState.userFriendlyError,
            'Terjadi masalah pada server. Harap coba lagi beberapa saat.');
      });

      test('should return "Terjadi kesalahan" when error is unknown', () {
        const errorMessage = 'Unknown error';
        final errorState = RestaurantReviewErrorState(errorMessage);

        expect(errorState.userFriendlyError,
            'Terjadi kesalahan. Silakan coba lagi.');
      });
    });

    group('RestaurantReviewLoadedState', () {
      test(
          'should contain a list of customer reviews when RestaurantReviewLoadedState is created',
          () {
        // Data mock
        final mockCustomerReviews = [
          CustomerReview(
            name: "Ahmad",
            review: "Tidak rekomendasi untuk pelajar!",
            date: "13 November 2019",
          ),
          CustomerReview(
            name: "test",
            review: "makanannya lezat",
            date: "29 Oktober 2020",
          ),
        ];

        // Buat state dengan data mock
        final loadedState = RestaurantReviewLoadedState(mockCustomerReviews);

        // Verifikasi data
        expect(loadedState.customerReviews, mockCustomerReviews);
        expect(loadedState.customerReviews.length, 2);

        // Verifikasi data pertama
        expect(loadedState.customerReviews[0].name, "Ahmad");
        expect(loadedState.customerReviews[0].review,
            "Tidak rekomendasi untuk pelajar!");
        expect(loadedState.customerReviews[0].date, "13 November 2019");

        // Verifikasi data kedua
        expect(loadedState.customerReviews[1].name, "test");
        expect(loadedState.customerReviews[1].review, "makanannya lezat");
        expect(loadedState.customerReviews[1].date, "29 Oktober 2020");
      });
    });
  });
}
