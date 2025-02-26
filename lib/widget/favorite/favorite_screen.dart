import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/favorite/local_database_provider.dart';
import 'package:restaurant_app/widget/detail/detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<LocalDatabaseProvider>().loadAllRestaurantValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Favorite"),
        centerTitle: true,
      ),
      body: Consumer<LocalDatabaseProvider>(
        builder: (context, value, child) {
          final favoriteList = value.restaurantList ?? [];
          print("Favorite list length: ${favoriteList.length}");
          return favoriteList.isEmpty
              ? Center(
                  child: Text(
                    "No favorites added yet.",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              : ListView.builder(
                  itemCount: favoriteList.length,
                  itemBuilder: (context, index) {
                    final restaurant = favoriteList[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailScreen(restId: restaurant.id),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    restaurant.name,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text(
                                    restaurant.city,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        restaurant.rating.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
