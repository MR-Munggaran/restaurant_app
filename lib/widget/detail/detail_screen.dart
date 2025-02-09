import 'package:flutter/material.dart';
import 'package:restaurant_app/widget/detail/detail_widget.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Hits"),
        centerTitle: true,
      ),
      body: DetailWidget(),
    );
  }
}
