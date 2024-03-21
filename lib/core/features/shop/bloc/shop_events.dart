import 'package:equatable/equatable.dart';
import 'package:ecohouse/core/features/shop/models/item.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();
}

class ShopFetchEvent extends ShopEvent {
  @override
  List<Object?> get props => [];
}

class ToggaleItemEvent extends ShopEvent {
  final ItemModule item;
  const ToggaleItemEvent({required this.item});
  @override
  List<Object?> get props => [item];
}

class DeleteItemEvent extends ShopEvent {
  final ItemModule item;
  const DeleteItemEvent({required this.item});
  @override
  List<Object?> get props => [item];
}

class ClearCartEvent extends ShopEvent {
  @override
  List<Object?> get props => [];
}

class IncrementItemEvent extends ShopEvent {
  final String itemId;

  const IncrementItemEvent({required this.itemId});
  @override
  List<Object?> get props => [itemId];
}

class DecrementItemEvent extends ShopEvent {
  final String itemId;
  const DecrementItemEvent({required this.itemId});
  @override
  List<Object?> get props => [itemId];
}

class AddOrderEvent extends ShopEvent {
  @override
  List<Object?> get props => [];
}
