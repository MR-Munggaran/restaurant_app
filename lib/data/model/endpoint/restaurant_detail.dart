import './restaurant_review.dart';

class RestaurantDetail {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<Category> categories;
  final Menus menus;
  final double rating;
  late final List<CustomerReview> customerReviews;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    return RestaurantDetail(
      id: json['id'] ?? '', // Default to empty string if null
      name: json['name'] ?? 'Unknown', // Default name if null
      description: json['description'] ??
          'No description available', // Default description
      city: json['city'] ?? 'Unknown City', // Default city if null
      address: json['address'] ?? 'No address available', // Default address
      pictureId: json['pictureId'] ?? '', // Default to empty string if null
      categories: json['categories'] != null
          ? List<Category>.from(
              json['categories'].map((x) => Category.fromJson(x)))
          : [],
      menus: json['menus'] != null
          ? Menus.fromJson(json['menus'])
          : Menus(foods: [], drinks: []), // Default empty menus
      rating: json['rating'] != null
          ? json['rating'].toDouble()
          : 0.0, // Default rating
      customerReviews: json['customerReviews'] != null
          ? List<CustomerReview>.from(
              json['customerReviews'].map((x) => CustomerReview.fromJson(x)))
          : [], // Default to empty list
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "address": address,
      "city": city,
      "pictureId": pictureId,
      "rating": rating,
    };
  }
}

class Category {
  final String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        name: json['name'] ?? 'Unnamed Category'); // Default name if null
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
    };
  }
}

class Menus {
  final List<Food> foods;
  final List<Drink> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods: json['foods'] != null
          ? List<Food>.from(json['foods'].map((x) => Food.fromJson(x)))
          : [], // Default to empty list if null
      drinks: json['drinks'] != null
          ? List<Drink>.from(json['drinks'].map((x) => Drink.fromJson(x)))
          : [], // Default to empty list if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "foods": foods.map((food) => food.toJson()).toList(),
      "drinks": drinks.map((drink) => drink.toJson()).toList(),
    };
  }
}

class Food {
  final String name;

  Food({required this.name});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(name: json['name'] ?? 'Unnamed Food'); // Default name if null
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
    };
  }
}

class Drink {
  final String name;

  Drink({required this.name});

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(name: json['name'] ?? 'Unnamed Drink'); // Default name if null
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
    };
  }
}
