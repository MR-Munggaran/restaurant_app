import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/res/restaurant_review_response.dart';
import 'package:restaurant_app/data/model/endpoint/restaurant_review.dart';
import 'package:restaurant_app/provider/review/restaurant_review_provider.dart';
import 'package:restaurant_app/static/restaurant_review_result_state.dart';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  late MockApiServices mockApiServices;
  late RestaurantReviewProvider provider;

  setUp(() {
    mockApiServices = MockApiServices();
    provider = RestaurantReviewProvider(mockApiServices);
  });

  final mockReviews = [
    CustomerReview(
        name: "Ahmad",
        review: "Tidak rekomendasi untuk pelajar!",
        date: "13 November 2019"),
    CustomerReview(
        name: "test", review: "makanannya lezat", date: "29 Oktober 2020"),
  ];

  test('Initial state should be RestaurantReviewNoneState', () {
    expect(provider.resultState, isA<RestaurantReviewNoneState>());
  });

  test(
      'Should emit RestaurantReviewLoadingState and then RestaurantReviewLoadedState when posting a review successfully',
      () async {
    final mockResponse = ReviewResponse(
      error: false,
      message: "success",
      customerReviews: mockReviews,
    );

    when(() => mockApiServices.postReview(
          restaurantId: "rqdv5juczeskfw1e867",
          name: "John Doe",
          review: "Makanannya enak",
        )).thenAnswer((_) async => mockResponse);

    final future = provider.postReview(
        "rqdv5juczeskfw1e867", "John Doe", "Makanannya enak");

    expect(provider.resultState, isA<RestaurantReviewLoadingState>());
    await future;
    expect(provider.resultState, isA<RestaurantReviewLoadedState>());
    expect(provider.customerReviews, equals(mockReviews));
  });

  test('Should emit RestaurantReviewErrorState when posting review fails',
      () async {
    when(() => mockApiServices.postReview(
          restaurantId: "rqdv5juczeskfw1e867",
          name: "John Doe",
          review: "Makanannya enak",
        )).thenThrow(Exception('Failed to load'));

    await provider.postReview(
        "rqdv5juczeskfw1e867", "John Doe", "Makanannya enak");

    expect(provider.resultState, isA<RestaurantReviewErrorState>());
  });

  test('Should emit RestaurantReviewErrorState when name or review is empty',
      () async {
    await provider.postReview("rqdv5juczeskfw1e867", "", "");

    expect(provider.resultState, isA<RestaurantReviewErrorState>());
  });

  test('Should update customer reviews correctly', () {
    provider.updateRestaurantReviews(mockReviews);
    expect(provider.customerReviews, equals(mockReviews));
  });
}
