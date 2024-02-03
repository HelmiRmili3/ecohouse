
import 'package:ecohouse/core/features/shopping/bloc/shopping_card_bloc.dart';
import 'package:ecohouse/core/features/shopping/bloc/shopping_card_events.dart';
import 'package:ecohouse/core/features/shopping/bloc/shopping_card_states.dart';
import 'package:ecohouse/core/features/shopping/presentation/widgets/custom_app_bar.dart';
import 'package:ecohouse/core/features/shopping/presentation/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenClient extends StatefulWidget {
  const HomeScreenClient({Key? key}) : super(key: key);

  @override
  State<HomeScreenClient> createState() => _HomeScreenClientState();
}

class _HomeScreenClientState extends State<HomeScreenClient> {

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
