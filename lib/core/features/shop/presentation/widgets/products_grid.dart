import 'dart:io';

import 'package:ecohouse/core/features/shop/bloc/shopping_card_bloc.dart';
import 'package:ecohouse/core/features/shop/bloc/shopping_card_events.dart';
import 'package:ecohouse/core/features/shop/models/product.dart';
import 'package:ecohouse/core/features/orders/presentation/screens/orders_screen_client.dart';
import 'package:ecohouse/core/features/shop/presentation/widgets/product_card.dart';
import 'package:ecohouse/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class ProductsGrid extends StatefulWidget {
  final List<ProductModule> products;

  const ProductsGrid({Key? key, required this.products}) : super(key: key);

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  File? image;

  Future<void> handleAddProduct() async {
    try {
      image = await pickImage();
      // ignore: use_build_context_synchronously
      await BlocProvider.of<ShoppingCartBloc>(context)
          .repository
          .addProduct(
              ProductModule(
                  id: const Uuid().v1(),
                  name: "name",
                  pointsPerKg: 200,
                  weight: 0),
              image)
          .then(((value) {
        BlocProvider.of<ShoppingCartBloc>(context).repository.fetchProducts();
      }));
      setState(() {});
    } catch (e) {
      //print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 500,
            child: GridView.builder(
              itemCount: widget.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(product: widget.products[index]);
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await BlocProvider.of<ShoppingCartBloc>(context)
                      .repository
                      .addOrder(widget.products)
                      .then(
                        (value) =>
                            BlocProvider.of<ShoppingCartBloc>(context).add(
                          FetchProducts(),
                        ),
                      )
                      .then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderScreenClient(),
                      ),
                    );
                  });
                },
                child: const Text("Continue"),
              ),
              // const SizedBox(
              //   width: 20,
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => const OrderScreenClient(),
              //       ),
              //     );
              //   },
              //   child: const Text("Orders"),
              // ),
              // const SizedBox(
              //   width: 20,
              // ),
              // ElevatedButton(
              //   onPressed: handleAddProduct,
              //   child: const Text("Add Product"),
              // )
            ],
          )
        ],
      ),
    );
  }
}
