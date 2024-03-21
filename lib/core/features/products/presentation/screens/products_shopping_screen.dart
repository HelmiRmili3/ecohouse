import 'package:ecohouse/core/features/products/bloc/shopping_card_bloc.dart';
import 'package:ecohouse/core/features/products/bloc/shopping_card_events.dart';
import 'package:ecohouse/core/features/products/bloc/shopping_card_states.dart';
import 'package:ecohouse/core/features/products/presentation/widgets/total_card.dart';
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
    final bloc = BlocProvider.of<ShoppingCartBloc>(context);
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
            int points =
                bloc.repository.calculateTotalPoints(state.selectedproducts);
            int weight =
                bloc.repository.calculateTotalWeight(state.selectedproducts);
            return SafeArea(
              minimum: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 550,
                    child: ListView.builder(
                      itemCount: state.selectedproducts.length,
                      itemBuilder: (context, index) {
                        return ProductCard2(
                          product: state.selectedproducts[index],
                        );
                      },
                    ),
                  ),
                  TotalCard(weight: weight, points: points),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blueAccent),
                    ),
                    onPressed: bloc.selectedProducts.isNotEmpty
                        ? () {
                            bloc.add(AddOrder());
                            Navigator.pop(context);
                          }
                        : null,
                    child: const Text(
                      "Confirme",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        bloc.add(ClearCart());
                        Navigator.pop(context);
                      },
                      child: const Text("Clear cart"))
                ],
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
