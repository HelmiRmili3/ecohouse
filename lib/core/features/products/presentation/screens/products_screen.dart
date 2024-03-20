import 'package:ecohouse/config/routes.dart';
import 'package:ecohouse/core/features/products/bloc/shopping_card_bloc.dart';
import 'package:ecohouse/core/features/products/bloc/shopping_card_events.dart';
import 'package:ecohouse/core/features/products/bloc/shopping_card_states.dart';
import 'package:ecohouse/core/features/products/presentation/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shop/presentation/widgets/customAppBar.dart';
import '../../models/product.dart';
import '../widgets/product_card.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShoppingCartBloc>(context).add(FetchProducts());
    BlocProvider.of<ShoppingCartBloc>(context).add(ClearCart());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
      builder: (context, state) {
        if (state is ShoppingCartLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ShoppingCartLoaded) {
          return Scaffold(
            appBar: buildCustomAppBar(
                context,
                "Ecohouse",
                BlocProvider.of<ShoppingCartBloc>(context)
                    .selectedProducts
                    .length, () {
              Navigator.pushNamed(context, Routes.shoppingCard);
            }),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProductsGrid(
                  products: state.products,
                  crossAxisCount:
                      2, // Example count, you can change as per your requirement
                  productCardBuilder: (ProductModule product) {
                    return ProductCard(product: product);
                  },
                )
              ],
            ),
          );
        } else if (state is ShoppingCartError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }
}
