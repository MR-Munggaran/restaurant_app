import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/endpoint/restaurant.dart';
import 'package:restaurant_app/widget/home/home_widget.dart';

void main() {
  testWidgets('HomeWidget should display restaurant details correctly',
      (WidgetTester tester) async {
    // Arrange
    final restaurant = Restaurant.fromJson({
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    });

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HomeWidget(
            restaurant: restaurant,
            onTap: () {},
          ),
        ),
      ),
    );

    // Assert
    expect(find.text('Melting Pot'), findsOneWidget);
    expect(find.text('Medan'), findsOneWidget);
    expect(find.text('4.2'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
