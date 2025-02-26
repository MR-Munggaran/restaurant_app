import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/widget/favorite/favorite_screen.dart';
import 'package:restaurant_app/widget/home/home_screen.dart';
import 'package:restaurant_app/widget/search/search_screen.dart';
import '../provider/index_nav_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNavBar) {
            1 => const SearchScreen(),
            2 => const FavoriteScreen(),
            _ => const HomeScreen(),
          };
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
        onTap: (index) {
          context.read<IndexNavProvider>().setIndexBottomNavBar = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            tooltip: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
            tooltip: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
            tooltip: "Favorite",
          ),
        ],
      ),
    );
  }
}
