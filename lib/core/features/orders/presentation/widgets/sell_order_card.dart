import 'package:ecohouse/core/features/products/models/sell_order.dart';
import 'package:flutter/material.dart';


class SellOrderCard extends StatelessWidget {
  final SellOrderModule order;

  const SellOrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin:const EdgeInsets.all(8),
      child: Padding(
        padding:const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order.id}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(

              'Customer ID: ${order.customerId}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              'Order Date: ${order.orderDate.toString()}',
              style:const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
