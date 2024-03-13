import 'package:ecohouse/core/features/products/bloc/shopping_card_bloc.dart';
import 'package:ecohouse/core/features/products/bloc/shopping_card_events.dart';
import 'package:ecohouse/core/features/products/bloc/shopping_card_states.dart';
import 'package:ecohouse/core/features/products/presentation/widgets/custom_app_bar.dart';
import 'package:ecohouse/core/features/products/presentation/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreenClient extends StatefulWidget {
  const ProductScreenClient({super.key});

  @override
  State<ProductScreenClient> createState() => _ProductScreenClientState();
}

class _ProductScreenClientState extends State<ProductScreenClient> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShoppingCartBloc>(context).add(FetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
            builder: (context, state) {
              if (state is ShoppingCartLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ShoppingCartLoaded) {
                return ProductsGrid(products: state.products);
              } else if (state is ShoppingCartError) {
                return Center(child: Text('Error: ${state.message}'));
              } else {
                return const Center(child: Text('Unknown state'));
              }
            },
          ),
        ],
      ),
    );
  }
}
