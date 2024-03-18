import 'package:ecohouse/core/features/shop/bloc/shop_bloc.dart';
import 'package:ecohouse/core/features/shop/bloc/shop_events.dart';
import 'package:ecohouse/core/features/shop/bloc/shop_states.dart';
import 'package:ecohouse/core/features/shop/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopShoppingCard extends StatefulWidget {
  final List<ItemModule> items;
  const ShopShoppingCard({
    super.key,
    required this.items,
  });

  @override
  State<ShopShoppingCard> createState() => _ShopShoppingCardState();
}

class _ShopShoppingCardState extends State<ShopShoppingCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Shopping Card"),
          centerTitle: true,
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 600.0,
                child: BlocBuilder<ShopBloc, ShopState>(
                  builder: (context, state) {
                    if (state is ShopInitialState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ShopLoadedState) {
                      return ListView.builder(
                        itemCount: widget.items.length,
                        itemBuilder: (context, index) {
                          return Container(
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
                                        widget.items[index].imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            widget.items[index].name,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          // Points
                                          Text(
                                            '\$${widget.items[index].points}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.green,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          // Description
                                          Text(
                                            widget.items[index].description,
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                          const SizedBox(height: 10),
                                          // Add to Cart buttons
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                          );
                        },
                      );
                    } else if (state is ShopErrorState) {
                      return Center(
                        child: Text(state.error),
                      );
                    } else {
                      return const Center(
                        child: Text("unknown error"),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(onPressed: () {}, child: const Text("Buy")),
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<ShopBloc>(context).add(ClearCartEvent());
                    Navigator.pop(context);
                  },
                  child: const Text("Clear Cart"))
            ],
          ),
        ));
  }
}
