import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: const Center(child: Text("shop screen")),
    );
  }
}
