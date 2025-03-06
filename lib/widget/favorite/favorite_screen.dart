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
      appBar: AppBar(title: const Text("My Favorite"), centerTitle: true),
      body: Consumer<LocalDatabaseProvider>(
        builder: (context, value, child) {
          final favoriteList = value.restaurantList ?? [];

          if (value.message.contains("Failed")) {
            return Center(
              child: Text(value.message, style: TextStyle(color: Colors.red)),
            );
          }

          if (favoriteList.isEmpty) {
            return Center(
              child: Text(
                "No favorites added yet.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: favoriteList.length,
            itemBuilder: (context, index) {
              final restaurant = favoriteList[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailScreen(restId: restaurant.id.toString()),
                    ),
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Icon(Icons.error_outline, color: Colors.red);
                      },
                    ),
                  ),
                  title: Text(restaurant.name.toString()),
                  subtitle: Text(restaurant.city.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      SizedBox(width: 4),
                      Text(restaurant.rating.toString()),
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
