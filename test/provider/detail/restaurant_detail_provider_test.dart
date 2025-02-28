import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/endpoint/restaurant_detail.dart';
import 'package:restaurant_app/data/model/endpoint/restaurant_review.dart';
import 'package:restaurant_app/data/model/res/restaurant_detail_response.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  late MockApiServices mockApiServices;
  late RestaurantDetailProvider provider;

  setUp(() {
    mockApiServices = MockApiServices();
    provider = RestaurantDetailProvider(mockApiServices);
  });

  test(
      'Should emit RestaurantDetailLoadingState and then RestaurantDetailLoadedState when data is fetched successfully',
      () async {
    final mockResponse = RestaurantDetailResponse(
      error: false,
      message: 'success',
      restaurant: RestaurantDetail(
        id: 'rqdv5juczeskfw1e867',
        name: 'Melting Pot',
        description:
            'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.',
        city: 'Medan',
        address: 'Jln. Pandeglang no 19',
        pictureId: '14',
        rating: 4.2,
        categories: [
          Category(name: 'Italia'),
          Category(name: 'Modern'),
        ],
        menus: Menus(
          foods: [
            Food(name: 'Paket rosemary'),
            Food(name: 'Toastie salmon'),
          ],
          drinks: [
            Drink(name: 'Es krim'),
            Drink(name: 'Sirup'),
          ],
        ),
        customerReviews: [
          CustomerReview(
            name: 'Ahmad',
            review: 'Tidak rekomendasi untuk pelajar!',
            date: '13 November 2019',
          ),
        ],
      ),
    );

    when(() => mockApiServices.getRestaurantDetail(any()))
        .thenAnswer((_) async => mockResponse);

    final future = provider.fetchRestaurantDetail('rqdv5juczeskfw1e867');

    expect(provider.resultState, isA<RestaurantDetailLoadingState>());
    await future;
    expect(provider.resultState, isA<RestaurantDetailLoadedState>());
  });

  test('Should emit RestaurantDetailErrorState when API returns an error',
      () async {
    final mockResponse = RestaurantDetailResponse(
      error: true,
      message: 'Failed to fetch data',
      restaurant: RestaurantDetail(
        id: '',
        name: '',
        description: '',
        city: '',
        address: '',
        pictureId: '',
        rating: 0.0,
        categories: [],
        menus: Menus(foods: [], drinks: []),
        customerReviews: [],
      ),
    );

    when(() => mockApiServices.getRestaurantDetail(any()))
        .thenAnswer((_) async => mockResponse);

    await provider.fetchRestaurantDetail('invalid_id');

    expect(provider.resultState, isA<RestaurantDetailErrorState>());
  });

  test('Should emit RestaurantDetailErrorState when an exception occurs',
      () async {
    when(() => mockApiServices.getRestaurantDetail(any()))
        .thenThrow(Exception('No Internet Connection'));

    await provider.fetchRestaurantDetail('rqdv5juczeskfw1e867');

    expect(provider.resultState, isA<RestaurantDetailErrorState>());
  });
}
