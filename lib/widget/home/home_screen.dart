import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';
import 'package:restaurant_app/widget/home/home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Hits"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text("List Restaurant",
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(
                  "This is Restaurant For You Gen Z",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(12), // Menentukan border radius
                child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/Resot.jpeg',
                    fit: BoxFit
                        .cover, // Agar gambar memenuhi area dan mempertahankan proporsinya
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Consumer<RestaurantListProvider>(
                  builder: (context, value, child) {
                return switch (value.resultState) {
                  RestaurantListLoadingState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  RestaurantListLoadedState(data: var restaurantList) =>
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        crossAxisSpacing: 7,
                        mainAxisSpacing: 7,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: restaurantList.length,
                      itemBuilder: (context, index) {
                        final restaurant = restaurantList[index];

                        return HomeWidget(
                          restaurant: restaurant,
                          onTap: () => Navigator.pushNamed(
                            context,
                            NavigationRoute.detailRoute.name,
                            arguments: restaurant.id,
                          ),
                        );
                      },
                    ),
                  RestaurantListErrorState(error: var message) =>
                    // Menampilkan Snackbar saat error terjadi
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
              }),
            ],
          ),
        ),
      ),
    );
  }
}
