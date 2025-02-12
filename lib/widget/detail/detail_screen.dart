import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';
import 'package:restaurant_app/widget/detail/detail_widget.dart';

class DetailScreen extends StatefulWidget {
  final String restId;
  const DetailScreen({super.key, required this.restId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<RestaurantDetailProvider>()
          .fetchRestaurantDetail(widget.restId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Hits"),
        centerTitle: true,
      ),
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantDetailLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
            RestaurantDetailLoadedState(data: var restaurant) =>
              DetailWidget(restaurant: restaurant),
            RestaurantDetailErrorState(
              error: var message
            ) => // Menampilkan Snackbar saat error terjadi
              Builder(
                builder: (context) {
                  // Pastikan Snackbar ditampilkan setelah UI selesai dirender
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  });
                  return const SizedBox(); // Tidak perlu menampilkan widget lain
                },
              ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
