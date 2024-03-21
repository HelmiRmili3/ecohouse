import 'package:ecohouse/core/features/products/models/product.dart';
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
  const AddProduct({required this.product});
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

class DeleteProduct extends ShoppingCartEvent {
  final String productId;
  const DeleteProduct({required this.productId});
  @override
  List<Object?> get props => [productId];
}

class ClearCart extends ShoppingCartEvent {
  @override
  List<Object?> get props => [];
}

class AddOrder extends ShoppingCartEvent {
  //final SellOrderModule order;

  //const AddOrder({required this.order});
  @override
  List<Object?> get props => [];
}
