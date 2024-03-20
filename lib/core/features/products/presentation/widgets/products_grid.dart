import 'package:ecohouse/core/features/products/models/product.dart';
import 'package:flutter/material.dart';

class ProductsGrid extends StatefulWidget {
  final List<ProductModule> products;
  final int crossAxisCount;
  final Widget Function(ProductModule) productCardBuilder;

  const ProductsGrid({
    Key? key,
    required this.products,
    required this.crossAxisCount,
    required this.productCardBuilder,
  }) : super(key: key);

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 500,
            child: GridView.builder(
              itemCount: widget.products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.crossAxisCount,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return widget.productCardBuilder(widget.products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
