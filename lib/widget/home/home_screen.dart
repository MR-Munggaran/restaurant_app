import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/res/restaurant_list_response.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/widget/home/home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<RestaurantListResponse> _futureRestaurantResponse;

  @override
  void initState() {
    super.initState();
    _futureRestaurantResponse = ApiServices().getRestaurantList();
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
              const Center(
                child: Text(
                  "List Restaurant",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Center(
                child: Text(
                  "This is Restaurant For You Gen Z",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      spreadRadius: 2,
                    )
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  height: 250,
                  width: double.infinity,
                  color: Colors.blue, // Mengganti gambar dengan warna solid
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FutureBuilder<RestaurantListResponse>(
                future: _futureRestaurantResponse,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(snapshot.error.toString()),
                        ),
                      );
                    }

                    final listOfRestaurant = snapshot.data!.restaurants;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        crossAxisSpacing: 7,
                        mainAxisSpacing: 7,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: listOfRestaurant.length,
                      itemBuilder: (context, index) {
                        final restaurant = listOfRestaurant[index];

                        return HomeWidget(
                          restaurant: restaurant,
                          onTap: () => Navigator.pushNamed(
                            context,
                            NavigationRoute.detailRoute.name,
                            arguments: restaurant,
                          ),
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
