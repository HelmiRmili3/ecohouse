import 'package:equatable/equatable.dart';

import '../models/item.dart';

abstract class ShopState extends Equatable {
  const ShopState();
}

class ShopInitialState extends ShopState {
  @override
  List<Object?> get props => [];
}

class ShopLoadedState extends ShopState {
  final List<ItemModule> items;
  final List<ItemModule> cart;
  const ShopLoadedState({required this.items, required this.cart});
  @override
  List<Object?> get props => [items, cart];
}

class ShopErrorState extends ShopState {
  final String error;

  const ShopErrorState({required this.error});

  @override
  List<Object?> get props => [];
}
