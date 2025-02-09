import 'package:flutter/material.dart';
import 'package:restaurant_app/widget/home/home_screen.dart';
import 'package:restaurant_app/widget/search/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _indexBottomNavBar = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_indexBottomNavBar],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indexBottomNavBar,
        onTap: (index) => setState(() {
          _indexBottomNavBar = index;
        }),
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
        ],
      ),
    );
  }
}
