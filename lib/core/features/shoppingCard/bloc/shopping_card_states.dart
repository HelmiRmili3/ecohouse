// shopping_cart_states.dart
import 'package:ecohouse/core/features/shoppingCard/models/product.dart';
import 'package:equatable/equatable.dart';

abstract class ShoppingCartState extends Equatable {
  const ShoppingCartState();

  @override
  List<Object> get props => [];

  Object? get products => props;
}

class ShoppingCartInitial extends ShoppingCartState {}

class ShoppingCartLoading extends ShoppingCartState {}

class ShoppingCartLoaded extends ShoppingCartState {
  @override
  final List<ProductModule> products;
  const ShoppingCartLoaded({required this.products});
  @override
  List<Object> get props => [products];
}

class ShoppingCartError extends ShoppingCartState {
  final String message;
  const ShoppingCartError({required this.message});
  @override
  List<Object> get props => [message];
}

class IncrementProductState extends ShoppingCartState {}

class DecrementProductState extends ShoppingCartState {}
