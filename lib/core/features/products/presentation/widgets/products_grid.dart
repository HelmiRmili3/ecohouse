
import 'package:ecohouse/core/features/products/models/product.dart';
import 'package:ecohouse/core/features/products/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductsGrid extends StatefulWidget {
  final List<ProductModule> products;
  const ProductsGrid({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
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
                return ProductCard(
                  product: widget.products[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


  // File? image;

  // Future<void> handleAddProduct() async {
  //   try {
  //     image = await pickImage();
  //     // ignore: use_build_context_synchronously
  //     await BlocProvider.of<ShoppingCartBloc>(context)
  //         .repository
  //         .addProduct(
  //             ProductModule(
  //                 id: const Uuid().v1(),
  //                 name: "name",
  //                 pointsPerKg: 200,
  //                 weight: 0),
  //             image)
  //         .then(((value) {
  //       BlocProvider.of<ShoppingCartBloc>(context).repository.fetchProducts();
  //     }));
  //     setState(() {});
  //   } catch (e) {
  //     //print(e);
  //   }
  // }

      // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.stretch,
                //   children: [
                //     ElevatedButton(
                //       onPressed: () async {
                //         await BlocProvider.of<ShoppingCartBloc>(context)
                //             .repository
                //             .addOrder(widget.products!)
                //             .then(
                //               (value) =>
                //                   BlocProvider.of<ShoppingCartBloc>(context).add(
                //                 FetchProducts(),
                //               ),
                //             )
                //             .then((value) {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) => const OrderScreenClient(),
                //             ),
                //           );
                //         });
                //       },
                //       child: const Text("Continue"),
                //     ),
                //     // const SizedBox(
                //     //   width: 20,
                //     // ),
                //     // ElevatedButton(
                //     //   onPressed: () {
                //     //     Navigator.push(
                //     //       context,
                //     //       MaterialPageRoute(
                //     //         builder: (context) => const OrderScreenClient(),
                //     //       ),
                //     //     );
                //     //   },
                //     //   child: const Text("Orders"),
                //     // ),
                //     // const SizedBox(
                //     //   width: 20,
                //     // ),
                //     // ElevatedButton(
                //     //   onPressed: handleAddProduct,
                //     //   child: const Text("Add Product"),
                //     // )
                //   ],
                // )