import 'package:ecohouse/core/features/orders/presentation/widgets/buy_order_card.dart';
import 'package:ecohouse/core/features/orders/repository/orders_repository.dart';
import 'package:ecohouse/core/features/shop/models/buy_order.dart';
import 'package:flutter/material.dart';

import '../../bloc/orders_bloc.dart';

class BuyOrderList extends StatelessWidget {
  const BuyOrderList({super.key});

  @override
  Widget build(BuildContext context) {
    final OrdersBloc ordersBloc =
        OrdersBloc(ordersRepository: OrdersRepository());
    return StreamBuilder<List<BuyOrderModule>>(
      stream: ordersBloc.buyordersStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<BuyOrderModule> orders = snapshot.data!;
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
                    child: BuyOrderCard(order: orders[index]),
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
