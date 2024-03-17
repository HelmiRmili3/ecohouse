import 'package:flutter/material.dart';

class ShopShoppingCard extends StatelessWidget {
  const ShopShoppingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Card"),
        centerTitle: true,
      ),
      body: const Center(
          child: Text(
        "Shop shopping card",
      )),
    );
  }
}
