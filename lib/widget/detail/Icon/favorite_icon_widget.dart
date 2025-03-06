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
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadFavoriteState();
  }

  Future<void> _loadFavoriteState() async {
    final localDatabaseProvider = context.read<LocalDatabaseProvider>();
    final favoriteIconProvider = context.read<FavoriteIconProvider>();

    await localDatabaseProvider.loadRestaurantValueById(widget.restaurant.id);
    final isFavorite = localDatabaseProvider.restaurant != null &&
        localDatabaseProvider.restaurant!.id == widget.restaurant.id;

    favoriteIconProvider.isFavorited = isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteIconProvider>(
      builder: (context, favoriteIconProvider, child) {
        return IconButton(
          onPressed: () async {
            final isFavorite = favoriteIconProvider.isFavorite;
            final localDatabaseProvider = context.read<LocalDatabaseProvider>();

            if (isFavorite) {
              await localDatabaseProvider
                  .removeRestaurantValueById(widget.restaurant.id);
            } else {
              await localDatabaseProvider
                  .saveRestaurantValue(widget.restaurant);
            }

            // Memuat ulang state favorit setelah perubahan
            await _loadFavoriteState();
          },
          icon: Icon(
            favoriteIconProvider.isFavorite
                ? Icons.favorite
                : Icons.favorite_border_outlined,
            color: Colors.red,
          ),
        );
      },
    );
  }
}
