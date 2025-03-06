import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_services.dart';

import 'fetch_api_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('ApiServices', () {
    late MockClient mockClient;
    late ApiServices apiServices;

    setUp(() {
      mockClient = MockClient();
      apiServices = ApiServices(client: mockClient);
    });

    group('getRestaurantList', () {
      test(
          'returns a RestaurantListResponse if the http call completes successfully',
          () async {
        final jsonString = '''
    {   "restaurants": [
          {
              "id": "rqdv5juczeskfw1e867",
              "name": "Melting Pot",
              "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
              "pictureId": "14",
              "city": "Medan",
              "rating": 4.2
          },
          {
              "id": "s1knt6za9kkfw1e867",
              "name": "Kafe Kita",
              "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
              "pictureId": "25",
              "city": "Gorontalo",
              "rating": 4
          }
      ]}
    ''';
        when(mockClient
                .get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
            .thenAnswer((_) async => http.Response(jsonString, 200));

        final response = await apiServices.getRestaurantList();
        expect(response.restaurants.length, 2); // Perbaiki jumlah restoran
        expect(response.restaurants.first.name,
            'Melting Pot'); // Perbaiki nama restoran
      });

      test('throws an exception if the http call completes with an error',
          () async {
        when(mockClient
                .get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(apiServices.getRestaurantList(), throwsException);
      });

      test('throws an exception if the response body is empty', () async {
        when(mockClient
                .get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
            .thenAnswer((_) async => http.Response('', 200));

        expect(apiServices.getRestaurantList(), throwsException);
      });
    });

    group('getRandomRestaurant', () {
      test('returns a Restaurant if the http call completes successfully',
          () async {
        final jsonString =
            '{"restaurants": [{"id": "1", "name": "Test Restaurant", "description": "Test Description"}]}';
        when(mockClient
                .get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
            .thenAnswer((_) async => http.Response(jsonString, 200));

        final restaurant = await apiServices.getRandomRestaurant();
        expect(restaurant.name, 'Test Restaurant');
      });

      test('throws an exception if the http call completes with an error',
          () async {
        when(mockClient
                .get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(apiServices.getRandomRestaurant(), throwsException);
      });

      test('throws an exception if the response body is empty', () async {
        when(mockClient
                .get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
            .thenAnswer((_) async => http.Response('', 200));

        expect(apiServices.getRandomRestaurant(), throwsException);
      });

      test('throws an exception if there are no restaurants available',
          () async {
        final jsonString = '{"restaurants": []}';
        when(mockClient
                .get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
            .thenAnswer((_) async => http.Response(jsonString, 200));

        expect(apiServices.getRandomRestaurant(), throwsException);
      });
    });

    group('getRestaurantDetail', () {
      test(
          'returns a RestaurantDetailResponse if the http call completes successfully',
          () async {
        final jsonString =
            '{"restaurant": {"id": "1", "name": "Test Restaurant", "description": "Test Description"}}';
        when(mockClient
                .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/1')))
            .thenAnswer((_) async => http.Response(jsonString, 200));

        final response = await apiServices.getRestaurantDetail('1');
        expect(response.restaurant.name, 'Test Restaurant');
      });

      test('throws an exception if the http call completes with an error',
          () async {
        when(mockClient
                .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/1')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(apiServices.getRestaurantDetail('1'), throwsException);
      });

      test('throws an exception if the response body is empty', () async {
        when(mockClient
                .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/1')))
            .thenAnswer((_) async => http.Response('', 200));

        expect(apiServices.getRestaurantDetail('1'), throwsException);
      });
    });

    group('searchRestaurant', () {
      test(
          'returns a SearchRestaurantResponse if the http call completes successfully',
          () async {
        final jsonString =
            '{"restaurants": [{"id": "1", "name": "Test Restaurant", "description": "Test Description"}]}';
        when(mockClient.get(
                Uri.parse('https://restaurant-api.dicoding.dev/search?q=test')))
            .thenAnswer((_) async => http.Response(jsonString, 200));

        final response = await apiServices.searchRestaurant('test');
        expect(response.restaurants.length, 1);
        expect(response.restaurants.first.name, 'Test Restaurant');
      });

      test('throws an exception if the http call completes with an error',
          () async {
        when(mockClient.get(
                Uri.parse('https://restaurant-api.dicoding.dev/search?q=test')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(apiServices.searchRestaurant('test'), throwsException);
      });

      test('throws an exception if the response body is empty', () async {
        when(mockClient.get(
                Uri.parse('https://restaurant-api.dicoding.dev/search?q=test')))
            .thenAnswer((_) async => http.Response('', 200));

        expect(apiServices.searchRestaurant('test'), throwsException);
      });
    });

    group('postReview', () {
      test('returns a ReviewResponse if the http call completes successfully',
          () async {
        final jsonString =
            '{"customerReviews": [{"name": "John Doe", "review": "Great restaurant!"}]}';
        when(mockClient.post(
          Uri.parse('https://restaurant-api.dicoding.dev/review'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(
              {"id": "1", "name": "John Doe", "review": "Great restaurant!"}),
        )).thenAnswer((_) async => http.Response(jsonString, 201));

        final response = await apiServices.postReview(
            restaurantId: '1', name: 'John Doe', review: 'Great restaurant!');
        expect(response.customerReviews.length, 1);
        expect(response.customerReviews.first.name, 'John Doe');
      });

      test('throws an exception if the http call completes with an error',
          () async {
        when(mockClient.post(
          Uri.parse('https://restaurant-api.dicoding.dev/review'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(
              {"id": "1", "name": "John Doe", "review": "Great restaurant!"}),
        )).thenAnswer((_) async => http.Response('Bad Request', 400));

        expect(
            apiServices.postReview(
                restaurantId: '1',
                name: 'John Doe',
                review: 'Great restaurant!'),
            throwsException);
      });

      test('throws an exception if the response body is empty', () async {
        when(mockClient.post(
          Uri.parse('https://restaurant-api.dicoding.dev/review'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(
              {"id": "1", "name": "John Doe", "review": "Great restaurant!"}),
        )).thenAnswer((_) async => http.Response('', 201));

        expect(
            apiServices.postReview(
                restaurantId: '1',
                name: 'John Doe',
                review: 'Great restaurant!'),
            throwsException);
      });
    });
  });
}
