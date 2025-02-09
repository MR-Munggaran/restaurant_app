import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final List<String> items = List.generate(10, (index) => "Nama Tempat");

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                color: Colors.brown[300], // Warna latar belakang pencarian
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
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.black54),
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
            child: SingleChildScrollView(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: items.length,
                shrinkWrap: true, // Supaya ukurannya menyesuaikan isi
                physics:
                    NeverScrollableScrollPhysics(), // ScrollView utama yang menangani scroll
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 50,
                            height: 50,
                            color: Colors.primaries[index %
                                Colors.primaries
                                    .length], // Warna berbeda untuk setiap item
                          ),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              items[index],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text("Tempat",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                            Text("Rating",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.orange)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
