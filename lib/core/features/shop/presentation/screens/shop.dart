import 'package:ecohouse/core/features/shop/bloc/shop_events.dart';
import 'package:ecohouse/core/features/shop/bloc/shop_states.dart';
import 'package:ecohouse/core/features/shop/repository/shop_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/routes.dart';
import '../../bloc/shop_bloc.dart';
import '../widgets/customAppBar.dart';
import '../widgets/shop_list_view.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopBloc>(
      create: (context) =>
          ShopBloc(repository: ShopRepository())..add(ShopFetchEvent()),
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          if (state is ShopInitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ShopLoadedState) {
            return Scaffold(
              appBar: buildCustomAppBar(
                context,
                "Shop",
                BlocProvider.of<ShopBloc>(context).updatedCart.length,
                () {
                  Navigator.pushNamed(context, Routes.shopshoppingCard);
                },
              ),
              body: SafeArea(
                minimum: const EdgeInsets.all(16.0),
                child: ShopListView(
                  items: state.items,
                  selectedItems: state.cart,
                ),
              ),
            );
          } else if (state is ShopErrorState) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return const Center(
              child: Text("No data found"),
            );
          }
        },
      ),
    );
  }
}
