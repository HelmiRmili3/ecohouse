import 'package:ecohouse/core/features/shop/bloc/shop_events.dart';
import 'package:ecohouse/core/features/shop/bloc/shop_states.dart';
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
  void initState() {
    BlocProvider.of<ShopBloc>(context).add(ShopFetchEvent());
    BlocProvider.of<ShopBloc>(context).add(ClearCartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
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
                Navigator.pushNamed(
                    context,
                    arguments: BlocProvider.of<ShopBloc>(context).updatedCart,
                    Routes.shopshoppingCard);
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
    );
  }
}
