class SearchRestaurant {
  final String? id; // Made nullable
  final String? name; // Made nullable
  final String? description; // Made nullable
  final String? pictureId; // Made nullable
  final String? city; // Made nullable
  final double? rating; // Made nullable

  SearchRestaurant({
    this.id, // Removed 'required' to allow null
    this.name, // Removed 'required' to allow null
    this.description, // Removed 'required' to allow null
    this.pictureId, // Removed 'required' to allow null
    this.city, // Removed 'required' to allow null
    this.rating, // Removed 'required' to allow null
  });

  factory SearchRestaurant.fromJson(Map<String, dynamic> json) {
    return SearchRestaurant(
      id: json['id'] as String?, // Cast to nullable String
      name: json['name'] as String?, // Cast to nullable String
      description: json['description'] as String?, // Cast to nullable String
      pictureId: json['pictureId'] as String?, // Cast to nullable String
      city: json['city'] as String?, // Cast to nullable String
      rating: (json['rating'] as num?)?.toDouble(), // Cast to nullable double
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "city": city,
      "pictureId": pictureId,
      "rating": rating,
    };
  }
}
