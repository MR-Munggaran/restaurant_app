import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/endpoint/restaurant_detail.dart';
import 'package:restaurant_app/provider/detail/favorite_icon_provider.dart';
import 'package:restaurant_app/provider/favorite/local_database_provider.dart';

class FavoriteIconWidget extends StatefulWidget {
  final RestaurantDetail restaurant;

  const FavoriteIconWidget({
    super.key,
    required this.restaurant,
  });

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  late final LocalDatabaseProvider localDatabaseProvider;
  late final FavoriteIconProvider favoriteIconProvider;

  @override
  void initState() {
    super.initState();
    // Move provider reads inside the build method or use context after the widget is fully initialized
    Future.microtask(() async {
      localDatabaseProvider = context.read<LocalDatabaseProvider>();
      favoriteIconProvider = context.read<FavoriteIconProvider>();

      await localDatabaseProvider.loadRestaurantValueById(widget.restaurant.id);
      final value = localDatabaseProvider.restaurant == null
          ? false
          : localDatabaseProvider.restaurant!.id == widget.restaurant.id;
      favoriteIconProvider.isFavorited = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final isFavorite = context.read<FavoriteIconProvider>().isFavorite;
        if (isFavorite) {
          await context
              .read<LocalDatabaseProvider>()
              .removeRestaurantValueById(widget.restaurant.id);
        } else {
          await context
              .read<LocalDatabaseProvider>()
              .saveRestaurantValue(widget.restaurant);
        }
        context.read<FavoriteIconProvider>().isFavorited = !isFavorite;
        context.read<LocalDatabaseProvider>().loadAllRestaurantValue();
      },
      icon: Icon(
        context.watch<FavoriteIconProvider>().isFavorite
            ? Icons.favorite
            : Icons.favorite_border_outlined,
        color: context.watch<FavoriteIconProvider>().isFavorite
            ? Colors.red
            : Colors.red,
      ),
    );
  }
}
