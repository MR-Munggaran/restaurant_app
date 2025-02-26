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
      id: json['id'],
      name: json['name'],
      description: json['description'],
      city: json['city'],
      address: json['address'],
      pictureId: json['pictureId'],
      // Handle categories, menus, and customerReviews gracefully when they're not needed
      categories: json['categories'] != null
          ? List<Category>.from(
              json['categories'].map((x) => Category.fromJson(x)))
          : [],
      menus: json['menus'] != null
          ? Menus.fromJson(json['menus'])
          : Menus(foods: [], drinks: []),
      rating: json['rating'] != null ? json['rating'].toDouble() : 0.0,
      customerReviews: json['customerReviews'] != null
          ? List<CustomerReview>.from(
              json['customerReviews'].map((x) => CustomerReview.fromJson(x)))
          : [],
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
    return Category(name: json['name']);
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
      foods: List<Food>.from(json['foods'].map((x) => Food.fromJson(x))),
      drinks: List<Drink>.from(json['drinks'].map((x) => Drink.fromJson(x))),
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
    return Food(name: json['name']);
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
    return Drink(name: json['name']);
  }
  Map<String, dynamic> toJson() {
    return {
      "name": name,
    };
  }
}
