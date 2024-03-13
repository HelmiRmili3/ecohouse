import 'package:flutter/material.dart';

class ProductShoppingCard extends StatelessWidget {
  const ProductShoppingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Card"),
        centerTitle: true,
      ),
      body: const Center(
          child: Text(
        "Product shopping card",
      )),
    );
  }
}
