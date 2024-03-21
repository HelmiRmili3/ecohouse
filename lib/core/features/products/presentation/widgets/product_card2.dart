import 'package:ecohouse/core/features/products/bloc/shopping_card_bloc.dart';
import 'package:ecohouse/core/features/products/bloc/shopping_card_events.dart';
import 'package:ecohouse/core/features/products/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard2 extends StatelessWidget {
  final ProductModule product;
  const ProductCard2({
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
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20.0)),
        margin: const EdgeInsets.all(4.0),
        height: 80,
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(product.image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    bloc.add(DecrementProduct(product.id));
                  },
                ),
                Text(
                  '${product.weight}',
                  style: const TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    bloc.add(IncrementProduct(product.id));
                  },
                ),
              ],
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                '${(product.pointsPerKg * product.weight).toString()} P',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
                onPressed: () {
                  bloc.add(DeleteProduct(productId: product.id));
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                )),
          ],
        ),
      ),
    );
  }
}
