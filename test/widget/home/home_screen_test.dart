import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/endpoint/restaurant.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';
import 'package:restaurant_app/widget/home/home_screen.dart';

class MockRestaurantListProvider extends Mock
    implements RestaurantListProvider {}

void main() {
  late MockRestaurantListProvider mockProvider;
  late List<Restaurant> restaurantList;

  setUp(() {
    mockProvider = MockRestaurantListProvider();
    restaurantList = [
      Restaurant.fromJson({
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description": "Lorem ipsum dolor sit amet...",
        "pictureId": "14",
        "city": "Medan",
        "rating": 4.2
      }),
      Restaurant.fromJson({
        "id": "s1knt6za9kkfw1e867",
        "name": "Kafe Kita",
        "description": "Quisque rutrum. Aenean imperdiet...",
        "pictureId": "25",
        "city": "Gorontalo",
        "rating": 4.0
      }),
    ];

    // Stub untuk fetchRestaurantList() agar tidak mengembalikan null
    when(() => mockProvider.fetchRestaurantList())
        .thenAnswer((_) async => Future.value());

    // Stub untuk resultState agar berisi daftar restoran
    when(() => mockProvider.resultState)
        .thenReturn(RestaurantListLoadedState(restaurantList));
  });

  testWidgets('HomeScreen should display restaurant list when state is loaded',
      (WidgetTester tester) async {
    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<RestaurantListProvider>.value(
          value: mockProvider,
          child: HomeScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle(); // Pastikan semua Future selesai

    // Assert
    expect(find.text('Melting Pot'), findsOneWidget);
    expect(find.text('Medan'), findsOneWidget);
    expect(find.text('4.2'), findsOneWidget);
    expect(find.text('Kafe Kita'), findsOneWidget);
    expect(find.text('Gorontalo'), findsOneWidget);
    expect(find.text('4.0'), findsOneWidget);

    // Verifikasi bahwa fetchRestaurantList() dipanggil satu kali
    verify(() => mockProvider.fetchRestaurantList()).called(1);
  });
}
