// shopping_cart_events.dart
import 'dart:io';

import 'package:ecohouse/core/features/shopping/models/product.dart';
import 'package:equatable/equatable.dart';

abstract class ShoppingCartEvent extends Equatable {
  const ShoppingCartEvent();
}

class FetchProducts extends ShoppingCartEvent {
  @override
  List<Object?> get props => [];
}

class AddProduct extends ShoppingCartEvent {
  final ProductModule product;
  final File? image;
  const AddProduct(this.product, this.image);

  @override
  List<Object?> get props => [product];
}

class IncrementProduct extends ShoppingCartEvent {
  final String productId;

  const IncrementProduct(this.productId);

  @override
  List<Object?> get props => [productId];
}

class DecrementProduct extends ShoppingCartEvent {
  final String productId;

  const DecrementProduct(this.productId);

  @override
  List<Object?> get props => [productId];
}
