import 'package:ecohouse/core/features/orders/bloc/orders_bloc.dart';
import 'package:ecohouse/core/features/orders/bloc/orders_events.dart';
import 'package:ecohouse/core/features/orders/bloc/orders_states.dart';
import 'package:ecohouse/core/features/shoppingCard/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreenClient extends StatefulWidget {
  const OrderScreenClient({super.key});

  @override
  State<OrderScreenClient> createState() => _OrderScreenClientState();
}

class _OrderScreenClientState extends State<OrderScreenClient> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrdersBloc>(context).add(OrdersFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 600,
          padding: const EdgeInsets.all(16.0),
          child:
              BlocBuilder<OrdersBloc, OrdersState>(builder: (context, state) {
            if (state is OrdersInitialState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OrdersLoadedState) {
              return ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  OrderModule order = state.orders[index];
                  return Card(
                    elevation: 1,
                    margin:const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Kg :${order.totalPoints} "),
                            Text("Points :${order.totalWeight}"),
                            const IconButton(onPressed: null, icon: Icon(Icons.edit)),
                            const IconButton(
                                onPressed: null, icon: Icon(Icons.delete)),
                          ],
                        )),
                  );
                },
              );
            } else if (state is OrdersErrorState) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return const Center(
                child: Text("Unknown error !"),
              );
            }
          }),
        ),
      ),
    );
  }
}
