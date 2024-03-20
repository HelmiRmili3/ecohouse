// shopping_cart_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:ecohouse/core/features/products/repository/shopping_card_repository.dart';
import 'package:ecohouse/core/features/products/models/product.dart';

import 'shopping_card_events.dart';
import 'shopping_card_states.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  final ShoppingCardRepository repository;

  List<ProductModule> products = [];
  List<ProductModule> selectedProducts = [];

  ShoppingCartBloc({required this.repository}) : super(ShoppingCartInitial()) {
    on<FetchProducts>(_mapFetchProductsToState);
    on<AddProduct>(_mapAddProductToState);
    on<IncrementProduct>(_mapIncrementProductToState);
    on<DecrementProduct>(_mapDecrementProductToState);
    on<DeleteProduct>(_mapDeleteProductToState);
    on<ClearCart>(_mapClearCartToState);
  }

  void _mapFetchProductsToState(
      FetchProducts event, Emitter<ShoppingCartState> emit) async {
    emit(ShoppingCartLoading());
    try {
      products = await repository.fetchProducts();
      emit(ShoppingCartLoaded(
          products: products, selectedproducts: selectedProducts));
    } catch (e) {
      emit(ShoppingCartError(message: 'Failed to fetch products: $e'));
    }
  }

  void _mapAddProductToState(
      AddProduct event, Emitter<ShoppingCartState> emit) async {
    emit(ShoppingCartInitial());
    try {
      if (selectedProducts.contains(event.product)) {
        selectedProducts.remove(event.product);
      } else {
        selectedProducts.add(event.product);
      }
      emit(ShoppingCartLoaded(
          products: products, selectedproducts: selectedProducts));
    } catch (e) {
      emit(ShoppingCartError(message: 'Failed to add product: $e'));
    }
  }

  void _mapIncrementProductToState(
      IncrementProduct event, Emitter<ShoppingCartState> emit) async {
    emit(ShoppingCartInitial());
    try {
      for (var product in selectedProducts) {
        if (product.id == event.productId) {
          product.weight++;
        }
      }
      emit(ShoppingCartLoaded(
          products: products, selectedproducts: selectedProducts));
    } catch (e) {
      emit(ShoppingCartError(message: 'Failed to add product: $e'));
    }
  }

  void _mapDecrementProductToState(
    DecrementProduct event,
    Emitter<ShoppingCartState> emit,
  ) async {
    emit(ShoppingCartInitial());
    try {
      for (var product in selectedProducts) {
        if (product.id == event.productId) {
          if (product.weight > 1) {
            product.weight--;
          }
        }
      }
      emit(ShoppingCartLoaded(
          products: products, selectedproducts: selectedProducts));
    } catch (e) {
      emit(ShoppingCartError(message: 'Failed to add product: $e'));
    }
  }

  void _mapDeleteProductToState(
      DeleteProduct event, Emitter<ShoppingCartState> emit) {
    emit(ShoppingCartInitial());
    try {
      selectedProducts.removeWhere((product) => product.id == event.productId);
      emit(ShoppingCartLoaded(
          selectedproducts: selectedProducts, products: products));
    } catch (e) {
      emit(ShoppingCartError(message: e.toString()));
    }
  }

  void _mapClearCartToState(
      ClearCart event, Emitter<ShoppingCartState> emit) async {
    emit(ShoppingCartInitial());
    try {
      selectedProducts.clear();
      emit(ShoppingCartLoaded(
          selectedproducts: selectedProducts, products: products));
    } catch (e) {
      emit(ShoppingCartError(message: e.toString()));
    }
  }

}
