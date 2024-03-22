import 'package:ecohouse/core/features/orders/presentation/widgets/buy_order_list.dart';
import 'package:flutter/material.dart';

import '../widgets/sell_order_list.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenClientState();
}

class _OrderScreenClientState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Orders",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: [Tab(text: 'Buy'), Tab(text: 'Sell')],
          ),
        ),
        body: const TabBarView(
          children: [BuyOrderList(), SellOrderList()],
        ),
      ),
    );
  }
}
