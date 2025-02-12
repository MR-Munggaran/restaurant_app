import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/endpoint/restaurant.dart';

class HomeWidget extends StatelessWidget {
  final Restaurant restaurant;
  final Function() onTap;

  const HomeWidget({super.key, required this.onTap, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.orange[100],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: restaurant.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Center(
                      child: Icon(Icons.error),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Hero(
              tag: '${restaurant.id}-name',
              child: Material(
                color: Colors.transparent,
                child: Text(
                  restaurant.name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color:
                            Colors.black, // Menambahkan warna hitam pada teks
                      ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 4),
                Hero(
                  tag: '${restaurant.id}-city', // Unique tag for city
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      restaurant.city,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, size: 16, color: Colors.amber),
                const SizedBox(width: 4),
                Hero(
                  tag: '${restaurant.id}-rating', // Unique tag for rating
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      restaurant.rating.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
