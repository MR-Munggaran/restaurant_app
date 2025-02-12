import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search/restaurant_search_provider.dart';
import 'package:restaurant_app/static/restaurant_search_result_state.dart';

import './search_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Restaurant"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar dipindahkan ke dalam main body
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey[300], // Warna latar belakang pencarian
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.black54),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          context
                              .read<RestaurantSearchProvider>()
                              .fetchSearchResult(value);
                        },
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: Theme.of(context).textTheme.labelLarge,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // List View dibungkus dalam SingleChildScrollView agar bisa discroll
          Expanded(
            child: Consumer<RestaurantSearchProvider>(
              builder: (context, value, child) {
                if (value.resultState is RestaurantSearchNoneState) {
                  return Center(
                    child: Text(
                      "Enter a restaurant name to search",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  );
                } else if (value.resultState is RestaurantSearchLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (value.resultState is RestaurantSearchLoadedState) {
                  final restaurants =
                      (value.resultState as RestaurantSearchLoadedState).data;
                  return SearchWidget(
                      restaurants: restaurants); // Pass data to SearchWidget
                } else if (value.resultState is RestaurantSearchErrorState) {
                  final errorMessage =
                      (value.resultState as RestaurantSearchErrorState).error;

                  // Gunakan addPostFrameCallback untuk menampilkan snackbar setelah build
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(errorMessage),
                        backgroundColor: Colors.red,
                      ),
                    );
                  });

                  return const SizedBox();
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
