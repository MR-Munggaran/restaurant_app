import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/res/restaurant_search_response.dart';
import 'package:restaurant_app/data/model/endpoint/restaurant_search.dart';
import 'package:restaurant_app/provider/search/restaurant_search_provider.dart';
import 'package:restaurant_app/static/restaurant_search_result_state.dart';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  late MockApiServices mockApiServices;
  late RestaurantSearchProvider provider;

  setUp(() {
    mockApiServices = MockApiServices();
    provider = RestaurantSearchProvider(mockApiServices);
  });

  final mockRestaurants = [
    SearchRestaurant(
      id: "fnfn8mytkpmkfw1e867",
      name: "Makan Mudah",
      description: "But I must explain to you how all this mistaken idea...",
      city: "Medan",
      pictureId: "22",
      rating: 3.7,
    ),
  ];

  test('Initial state should be RestaurantSearchNoneState', () {
    expect(provider.resultState, isA<RestaurantSearchNoneState>());
  });

  test('Should return RestaurantSearchNoneState when query is empty', () async {
    await provider.fetchSearchResult("");
    expect(provider.resultState, isA<RestaurantSearchNoneState>());
  });

  test(
      'Should emit RestaurantSearchLoadingState and then RestaurantSearchLoadedState when fetching search results successfully',
      () async {
    final mockResponse = SearchRestaurantResponse(
      error: false,
      founded: 1,
      restaurants: mockRestaurants,
    );

    when(() => mockApiServices.searchRestaurant("Makan"))
        .thenAnswer((_) async => mockResponse);

    final future = provider.fetchSearchResult("Makan");

    expect(provider.resultState, isA<RestaurantSearchLoadingState>());
    await future;
    expect(provider.resultState, isA<RestaurantSearchLoadedState>());
  });

  test('Should emit RestaurantSearchErrorState when API returns an error',
      () async {
    final mockResponse = SearchRestaurantResponse(
      error: true,
      founded: 0,
      restaurants: [],
    );

    when(() => mockApiServices.searchRestaurant("Makan"))
        .thenAnswer((_) async => mockResponse);

    await provider.fetchSearchResult("Makan");

    expect(provider.resultState, isA<RestaurantSearchErrorState>());
  });

  test('Should emit RestaurantSearchErrorState when an exception occurs',
      () async {
    when(() => mockApiServices.searchRestaurant("Makan"))
        .thenThrow(Exception('Failed to load'));

    await provider.fetchSearchResult("Makan");

    expect(provider.resultState, isA<RestaurantSearchErrorState>());
  });
}
