import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/endpoint/restaurant_detail.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/review/restaurant_review_provider.dart';
import '../detail/Review/review_form_widget.dart';

class DetailWidget extends StatelessWidget {
  final RestaurantDetail restaurant;
  const DetailWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantReviewProvider>(
      builder: (context, reviewProvider, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Restaurant Name with Hero
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Hero(
                      tag: '${restaurant.id}-name',
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          restaurant.name,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Restaurant Address
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Icon(Icons.location_on),
                    const SizedBox(width: 4),
                    Text(
                      restaurant.address,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),

              // Restaurant Image with Hero
              Hero(
                tag: restaurant.id,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Image.network(
                    "https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}",
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 300,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: Center(
                          child: Text(
                            'Gagal memuat gambar',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      );
                    },
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
                        tag: '${restaurant.id}-city',
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            restaurant.city,
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
                          tag: '${restaurant.id}-rating',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              restaurant.rating.toString(),
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
                  restaurant.description,
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
                            children: restaurant.menus.foods.map((food) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
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
                            children: restaurant.menus.drinks.map((drink) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
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
                    if (restaurant.customerReviews.isEmpty)
                      Center(
                        child: Text("Belum ada ulasan.",
                            style: Theme.of(context).textTheme.bodyMedium),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: reviewProvider.customerReviews.length,
                        itemBuilder: (context, index) {
                          final review = reviewProvider.customerReviews[index];
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
                                      Expanded(
                                        child: Text(review.name.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black)),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(review.date.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(color: Colors.black)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(review.review.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.black)),
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
                restaurantId: restaurant.id,
                onReviewSubmitted: (newReviews) {
                  // Directly updating the reviews in the provider
                  reviewProvider.updateRestaurantReviews(newReviews);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
