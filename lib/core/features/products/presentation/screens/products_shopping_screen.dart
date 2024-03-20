import 'package:ecohouse/core/features/products/bloc/shopping_card_bloc.dart';
import 'package:ecohouse/core/features/products/bloc/shopping_card_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/product_card2.dart';

class ProductShoppingScreen extends StatefulWidget {
  const ProductShoppingScreen({super.key});

  @override
  State<ProductShoppingScreen> createState() => _ProductShoppingScreenState();
}

class _ProductShoppingScreenState extends State<ProductShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Card"),
        centerTitle: true,
      ),
      body: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
        builder: (context, state) {
          if (state is ShoppingCartInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ShoppingCartLoaded) {
            return SafeArea(
              minimum: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: state.selectedproducts.length,
                itemBuilder: (context, index) {
                  return ProductCard2(
                    product: state.selectedproducts[index],
                  );
                },
              ),
            );
          } else if (state is ShoppingCartError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(
              child: Text("Unkown error"),
            );
          }
        },
      ),
    );
  }
}
