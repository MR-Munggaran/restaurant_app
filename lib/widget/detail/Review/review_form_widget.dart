import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/endpoint/restaurant_review.dart';
import 'package:restaurant_app/provider/review/restaurant_review_provider.dart';
import 'package:restaurant_app/static/restaurant_review_result_state.dart';

class ReviewFormWidget extends StatelessWidget {
  final String restaurantId;
  final Function(List<CustomerReview>) onReviewSubmitted;

  const ReviewFormWidget({
    super.key,
    required this.restaurantId,
    required this.onReviewSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _reviewController = TextEditingController();
    final RestaurantReviewProvider reviewProvider =
        context.read<RestaurantReviewProvider>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Nama"),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _reviewController,
            decoration: const InputDecoration(labelText: "Tulis Review"),
            maxLines: 3,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final name = _nameController.text;
                final review = _reviewController.text;

                await reviewProvider.postReview(restaurantId, name, review);

                if (reviewProvider.resultState is RestaurantReviewLoadedState) {
                  onReviewSubmitted(
                    (reviewProvider.resultState as RestaurantReviewLoadedState)
                        .customerReviews,
                  );
                  _nameController.clear();
                  _reviewController.clear();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Review berhasil dikirim!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: reviewProvider.resultState is RestaurantReviewLoadingState
                  ? const CircularProgressIndicator()
                  : const Text("Kirim Review"),
            ),
          ),
          const SizedBox(height: 10),
          Consumer<RestaurantReviewProvider>(
            builder: (context, value, child) {
              if (value.resultState is RestaurantReviewLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (value.resultState is RestaurantReviewLoadedState) {
                return const SizedBox();
              } else if (value.resultState is RestaurantReviewErrorState) {
                final errorMessage =
                    (value.resultState as RestaurantReviewErrorState).error;

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(errorMessage),
                      backgroundColor: Colors.red,
                    ),
                  );
                });
                return const SizedBox();
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
