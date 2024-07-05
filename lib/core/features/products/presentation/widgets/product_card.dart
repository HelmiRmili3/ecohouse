import 'package:ecohouse/core/features/products/bloc/shopping_card_bloc.dart';
import 'package:ecohouse/core/features/products/bloc/shopping_card_events.dart';
import 'package:ecohouse/core/features/products/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  final ProductModule product;
  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ShoppingCartBloc>(context);
    return GestureDetector(
      onTap: () {
        bloc.add(AddProduct(product: product));
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: bloc.selectedProducts.contains(product)
              ? const BorderSide(color: Colors.blue, width: 2)
              : BorderSide.none,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16.0),
                  height: 80.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(product.image),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    product.name,
                    style:
                        const TextStyle(color: Colors.blueAccent, fontSize: 24),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8.h,
              right: 8.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.h),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  '${product.pointsPerKg.toString()} P',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
