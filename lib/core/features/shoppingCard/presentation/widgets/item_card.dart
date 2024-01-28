// import 'package:ecohouse/core/features/shoppingCard/bloc/shopping_card_bloc.dart';
// import 'package:ecohouse/core/features/shoppingCard/bloc/shopping_card_events.dart';
// import 'package:ecohouse/core/features/shoppingCard/bloc/shopping_card_states.dart';
// import 'package:ecohouse/core/features/shoppingCard/models/product.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';


// class ItemCard extends StatelessWidget {
//   final String imageUrl;
//   final String productName;
//   final int pointsPerKg;
//   final int
//       productId; // Assuming productId is needed for adding/removing from the cart

//   const ItemCard({
//     Key? key,
//     required this.imageUrl,
//     required this.productName,
//     required this.pointsPerKg,
//     required this.productId,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 10,
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 120.0,
//             height: 120.0,
//             child: ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(15),
//                 bottomLeft: Radius.circular(15),
//               ),
//               child: Image.asset(
//                 imageUrl,
//                 width: 120.0,
//                 height: 120.0,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const SizedBox(width: 20),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 10),
//               Text(
//                 productName,
//                 style: const TextStyle(fontSize: 24),
//               ),
//               Text(
//                 "$pointsPerKg points",
//                 style: const TextStyle(
//                   fontSize: 16,
//                   color: Color.fromARGB(255, 43, 143, 48),
//                 ),
//               ),
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       BlocProvider.of<ShoppingCartBloc>(context)
//                           .add(DecrementProduct(productId));
//                     },
//                     icon: const Icon(Icons.remove),
//                   ),
//                   const SizedBox(width: 10),
//                   BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
//                     builder: (context, state) {
//                       if (state is ShoppingCartLoaded) {
//                         return Text(
//                           state.products
//                               .firstWhere(
//                                 (product) => product.id == productId,
//                                 orElse: () => ProductModule(weight: 0),
//                               )
//                               .weight
//                               .toString(),
//                         );
//                       }
//                       return const Text("0");
//                     },
//                   ),
//                   const SizedBox(width: 10),
//                   IconButton(
//                     onPressed: () {
//                       BlocProvider.of<ShoppingCartBloc>(context)
//                           .add(IncrementProduct(productId));
//                     },
//                     icon: const Icon(Icons.add),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
