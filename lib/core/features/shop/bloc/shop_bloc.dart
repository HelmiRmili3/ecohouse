import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ecohouse/core/features/shop/bloc/shop_events.dart';
import 'package:ecohouse/core/features/shop/bloc/shop_states.dart';
import 'package:ecohouse/core/features/shop/models/item.dart';
import 'package:ecohouse/core/features/shop/repository/shop_repository.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final ShopRepository repository;
  String collectionName = "items";

  List<ItemModule> updatedCart = [];
  List<ItemModule> items = [];

  ShopBloc({required this.repository}) : super(ShopInitialState()) {
    on<ShopFetchEvent>(_mapShopFetchEventToState);
    on<ToggaleItemEvent>(_mapToggaleItemToState);
    on<ClearCartEvent>(_mapClearCartToState);
    on<DeleteItemEvent>(_mapDeleteItemToState);
    on<IncrementItemEvent>(_mapIncrementItemToState);
    on<DecrementItemEvent>(_mapDecrementItemToState);
    on<AddOrderEvent>(_mapAddOrderToState);
    //Filter event
  }
  FutureOr<void> _mapIncrementItemToState(
      IncrementItemEvent event, Emitter<ShopState> emit) {
    emit(ShopInitialState());
    try {
      for (var product in updatedCart) {
        if (product.id == event.itemId) {
          product.quantity++;
        }
      }
      emit(ShopLoadedState(items: items, cart: updatedCart));
    } catch (e) {
      emit(ShopErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _mapDecrementItemToState(
      DecrementItemEvent event, Emitter<ShopState> emit) {
    emit(ShopInitialState());
    try {
      for (var product in updatedCart) {
        if (product.id == event.itemId) {
          if (product.quantity > 1) {
            product.quantity--;
          }
        }
      }
      emit(ShopLoadedState(items: items, cart: updatedCart));
    } catch (e) {
      emit(ShopErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _mapAddOrderToState(
      AddOrderEvent event, Emitter<ShopState> emit) {
    emit(ShopInitialState());
    try {
      repository.addOrder(updatedCart);
      updatedCart.clear();
      emit(ShopLoadedState(items: items, cart: updatedCart));
    } catch (e) {
      emit(ShopErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _mapDeleteItemToState(
      DeleteItemEvent event, Emitter<ShopState> emit) async {
    emit(ShopInitialState());

    try {
      updatedCart.remove(event.item);
      emit(ShopLoadedState(items: items, cart: updatedCart));
    } catch (e) {
      emit(ShopErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _mapShopFetchEventToState(
      ShopFetchEvent event, Emitter<ShopState> emit) async {
    emit(ShopInitialState());
    try {
      items = await repository.fetchItems();
      emit(ShopLoadedState(items: items, cart: updatedCart));
    } catch (e) {
      emit(ShopErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _mapToggaleItemToState(
      ToggaleItemEvent event, Emitter<ShopState> emit) {
    emit(ShopInitialState());
    try {
      if (updatedCart.contains(event.item)) {
        updatedCart.remove(event.item);
      } else {
        updatedCart.add(event.item);
      }
      emit(ShopLoadedState(items: items, cart: updatedCart));
    } catch (e) {
      emit(ShopErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _mapClearCartToState(
      ClearCartEvent event, Emitter<ShopState> emit) async {
    emit(ShopInitialState());
    try {
      updatedCart.clear();
      emit(ShopLoadedState(items: items, cart: updatedCart));
    } catch (e) {
      emit(ShopErrorState(error: e.toString()));
    }
  }
}
