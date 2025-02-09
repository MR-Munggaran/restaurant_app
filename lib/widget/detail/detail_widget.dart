import 'package:flutter/material.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Restaurant name
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Nama',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),

          // Restaurant address
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.location_on),
                Expanded(
                  child: Text(
                    'Address',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),

          // Color section replacing image
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Container(
              height: 300,
              width: double.infinity,
              color: Colors.blue, // Ganti dengan warna yang diinginkan
              child: Center(
                child: Icon(
                  Icons.image_not_supported,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // City and rating
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment
                        .centerLeft, // Menyusun teks ke kiri dalam Expanded
                    child: Text(
                      'City',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment
                        .centerRight, // Menyusun ikon dan teks ke kanan dalam Expanded
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .min, // Supaya Row tidak mengambil seluruh lebar Expanded
                      children: [
                        Icon(Icons.star,
                            color: Colors
                                .amber), // Memberi jarak antara ikon dan teks
                        Flexible(
                          child: Text(
                            '4.6',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tags section
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.brown.shade200,
                    ),
                    child: Text(
                      "Main",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.brown.shade200,
                    ),
                    child: Text(
                      "Modern",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Description
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          // Menu colors replacing images
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Stack(
                        alignment:
                            Alignment.center, // Memposisikan label di tengah
                        children: [
                          Container(
                            color: Colors.green,
                          ),
                          Text(
                            "Green", // Label
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors
                                  .white, // Warna teks agar kontras dengan latar belakang
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            color: Colors.orange,
                          ),
                          Text(
                            "Orange",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            color: Colors.red,
                          ),
                          Text(
                            "Red",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(),
        ],
      ),
    );
  }
}
