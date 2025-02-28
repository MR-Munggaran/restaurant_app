import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/res/restaurant_list_response.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  late MockApiServices mockApiServices;
  late RestaurantListProvider provider;

  setUp(() {
    mockApiServices = MockApiServices();
    provider = RestaurantListProvider(mockApiServices);
  });

  test(
      'Should emit RestaurantListLoadingState and then RestaurantListLoadedState when data is fetched successfully',
      () async {
    final mockResponse = RestaurantListResponse(
      error: false,
      message: 'Success',
      restaurants: [],
      count: 20,
    );

    when(() => mockApiServices.getRestaurantList())
        .thenAnswer((_) async => mockResponse);

    final future = provider.fetchRestaurantList();

    expect(provider.resultState, isA<RestaurantListLoadingState>());
    await future;
    expect(provider.resultState, isA<RestaurantListLoadedState>());
  });

  test('Should emit RestaurantListErrorState when API returns an error',
      () async {
    final mockResponse = RestaurantListResponse(
      error: true,
      message: 'Failed to fetch data',
      restaurants: [],
      count: 20,
    );

    when(() => mockApiServices.getRestaurantList())
        .thenAnswer((_) async => mockResponse);

    await provider.fetchRestaurantList();

    expect(provider.resultState, isA<RestaurantListErrorState>());
  });

  test('Should emit RestaurantListErrorState when an exception occurs',
      () async {
    when(() => mockApiServices.getRestaurantList())
        .thenThrow(Exception('No Internet Connection'));

    await provider.fetchRestaurantList();

    expect(provider.resultState, isA<RestaurantListErrorState>());
  });
}
