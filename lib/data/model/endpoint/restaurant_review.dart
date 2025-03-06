class CustomerReview {
  final String? name; // Made nullable
  final String? review; // Made nullable
  final String? date; // Made nullable

  CustomerReview({
    this.name, // Removed 'required' to allow null
    this.review, // Removed 'required' to allow null
    this.date, // Removed 'required' to allow null
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return CustomerReview(
      name: json['name'] as String?, // Cast to nullable String
      review: json['review'] as String?, // Cast to nullable String
      date: json['date'] as String?, // Cast to nullable String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "review": review,
      "date": date,
    };
  }
}
