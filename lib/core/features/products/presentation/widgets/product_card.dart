import 'package:ecohouse/core/features/products/bloc/shopping_card_bloc.dart';
import 'package:ecohouse/core/features/products/bloc/shopping_card_events.dart';
import 'package:ecohouse/core/features/products/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  final ProductModule product;
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ShoppingCartBloc>(context);
    return GestureDetector(
      onTap: () {
        bloc.add(AddProduct(product: product));
      },
      child: Card(
        elevation: 5,
        color:
            bloc.selectedProducts.contains(product) ? Colors.greenAccent : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16.0),
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(product.image),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    product.name,
                    style:
                        const TextStyle(color: Colors.blueAccent, fontSize: 24),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8.0,
              right: 8.0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  '${product.pointsPerKg.toString()} P',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
