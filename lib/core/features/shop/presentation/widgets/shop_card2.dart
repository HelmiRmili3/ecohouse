import 'package:ecohouse/core/features/shop/bloc/shop_bloc.dart';
import 'package:ecohouse/core/features/shop/bloc/shop_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/item.dart';

class ShopCard2 extends StatelessWidget {
  final ItemModule item;
  const ShopCard2({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () {
          context.read<ShopBloc>().add(ToggaleItemEvent(item: item));
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide.none,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    color: Colors.grey[300],
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // Points
                        Text(
                          '\$${item.points}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // Description
                        Text(
                          item.description,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        // Add to Cart buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Edit'),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
