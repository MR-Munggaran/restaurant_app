import '../endpoint/restaurant_review.dart';

class ReviewResponse {
  final bool error;
  final String message;
  final List<CustomerReview> customerReviews;

  ReviewResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    return ReviewResponse(
      error: json['error'] ?? false, // Default value if null
      message: json['message'] ?? "", // Default value if null
      customerReviews: json['customerReviews'] != null // Check for null
          ? List<CustomerReview>.from(
              json['customerReviews'].map((x) => CustomerReview.fromJson(x)))
          : [], // Return empty list if null
    );
  }
}
