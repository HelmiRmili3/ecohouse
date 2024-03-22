import 'package:ecohouse/core/features/orders/repository/orders_repository.dart';
import 'package:ecohouse/core/features/products/models/sell_order.dart';
import 'package:flutter/material.dart';

import '../../bloc/orders_bloc.dart';
import 'sell_order_card.dart';

class SellOrderList extends StatelessWidget {
  const SellOrderList({super.key});

  @override
  Widget build(BuildContext context) {
    final OrdersBloc ordersBloc =
        OrdersBloc(ordersRepository: OrdersRepository());
    return StreamBuilder<List<SellOrderModule>>(
      stream: ordersBloc.sellordersStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<SellOrderModule> orders = snapshot.data!;
          return SafeArea(
            minimum: const EdgeInsets.all(16),
            child: SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, Routes.orderDetailsPage,
                      //     arguments: orders[index].products);
                    },
                    child: SellOrderCard(order: orders[index]),
                  );
                },
              ),
            ),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
