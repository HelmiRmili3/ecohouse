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
    final List<ProductModule> updatedProducts =
        (state.selectedproducts as List<ProductModule?>)
            .map((product) {
              if (product != null && product.id == event.productId) {
                return product.copyWith(weight: product.weight + 1);
              }
              return product;
            })
            .whereType<ProductModule>()
            .toList();

    emit(ShoppingCartLoaded(
        products: updatedProducts, selectedproducts: selectedProducts));
  }

  void _mapDecrementProductToState(
    DecrementProduct event,
    Emitter<ShoppingCartState> emit,
  ) async {
    final List<ProductModule> updatedProducts =
        (state.selectedproducts as List<ProductModule?>)
            .map((product) {
              if (product != null &&
                  product.id == event.productId &&
                  product.weight > 0) {
                return product.copyWith(weight: product.weight - 1);
              }
              return product;
            })
            .whereType<ProductModule>()
            .toList();

    emit(ShoppingCartLoaded(
        products: updatedProducts, selectedproducts: selectedProducts));
  }

  void _mapDeleteProductToState(
      DeleteProduct event, Emitter<ShoppingCartState> emit) {
    selectedProducts.removeWhere((product) => product.id == event.productId);
    emit(ShoppingCartLoaded(
        selectedproducts: selectedProducts, products: products));
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
