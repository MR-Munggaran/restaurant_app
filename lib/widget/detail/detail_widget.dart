import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/endpoint/restaurant_detail.dart';
import '../../data/model/endpoint/restaurant_review.dart';
import '../detail/Review/review_form_widget.dart';

class DetailWidget extends StatefulWidget {
  final RestaurantDetail restaurant;
  const DetailWidget({super.key, required this.restaurant});

  @override
  State<DetailWidget> createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  void _updateReviews(List<CustomerReview> newReviews) {
    setState(() {
      widget.restaurant.customerReviews.clear();
      widget.restaurant.customerReviews.addAll(newReviews);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Restaurant Name with Hero
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Hero(
              tag: '${widget.restaurant.id}-name',
              child: Material(
                color: Colors.transparent,
                child: Text(
                  widget.restaurant.name,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
          ),

          // Restaurant Address
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 4),
                Text(
                  widget.restaurant.address,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),

          // Restaurant Image with Hero
          Hero(
            tag: widget.restaurant.id,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Image.network(
                "https://restaurant-api.dicoding.dev/images/large/${widget.restaurant.pictureId}",
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // City and Rating with Hero
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Hero(
                    tag: '${widget.restaurant.id}-city',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        widget.restaurant.city,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 4),
                    Hero(
                      tag: '${widget.restaurant.id}-rating',
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          widget.restaurant.rating.toString(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.restaurant.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          // Menu drinks and foods
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul Menu Makanan dan Minuman
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Makanan',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Minuman',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // List Makanan dan Minuman
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // List Makanan (Kiri)
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: widget.restaurant.menus.foods.map((food) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(food.name),
                          );
                        }).toList(),
                      ),
                    ),

                    // List Minuman (Kanan)
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: widget.restaurant.menus.drinks.map((drink) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(drink.name),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Customer Reviews
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Customer Reviews',
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                if (widget.restaurant.customerReviews.isEmpty)
                  Center(
                    child: Text("Belum ada ulasan.",
                        style: Theme.of(context).textTheme.bodyMedium),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.restaurant.customerReviews.length,
                    itemBuilder: (context, index) {
                      final review = widget.restaurant.customerReviews[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade200,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(review.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  const SizedBox(width: 8),
                                  Text(review.date,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(review.review,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),

          ReviewFormWidget(
            restaurantId: widget.restaurant.id,
            onReviewSubmitted: _updateReviews,
          ),
        ],
      ),
    );
  }
}
