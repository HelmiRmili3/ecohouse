import 'package:ecohouse/core/features/shopping/bloc/shopping_card_bloc.dart';
import 'package:ecohouse/core/features/shopping/bloc/shopping_card_events.dart';
import 'package:ecohouse/core/features/shopping/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  final ProductModule product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<ShoppingCartBloc>(context)
                          .add(DecrementProduct(product.id));
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Text(product.weight.toString()),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<ShoppingCartBloc>(context)
                          .add(IncrementProduct(product.id));
                    },
                    icon: const Icon(Icons.add),
                  )
                ],
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
    );
  }
}
