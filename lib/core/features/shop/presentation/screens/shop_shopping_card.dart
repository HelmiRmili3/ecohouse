import 'package:ecohouse/core/features/shop/bloc/shop_bloc.dart';
import 'package:ecohouse/core/features/shop/bloc/shop_events.dart';
import 'package:ecohouse/core/features/shop/bloc/shop_states.dart';
import 'package:ecohouse/core/features/shop/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/shop_card2.dart';

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
                          return ShopCard2(
                            item: widget.items[index],
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
