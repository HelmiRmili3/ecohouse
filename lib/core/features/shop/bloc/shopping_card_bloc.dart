// shopping_cart_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:ecohouse/core/features/shop/repository/shopping_card_repository.dart';
import 'package:ecohouse/core/features/shop/models/product.dart';

import 'shopping_card_events.dart';
import 'shopping_card_states.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  final ShoppingCardRepository repository;

  List<ProductModule> products = [];

  ShoppingCartBloc({required this.repository}) : super(ShoppingCartInitial()) {
    on<FetchProducts>(_mapFetchProductsToState);
    on<AddProduct>(_mapAddProductToState);
    on<IncrementProduct>(_mapIncrementProductToState);
    on<DecrementProduct>(_mapDecrementProductToState);
  }

  void _mapFetchProductsToState(
      FetchProducts event, Emitter<ShoppingCartState> emit) async {
    emit(ShoppingCartLoading());
    try {
      products = await repository.fetchProducts();
      emit(ShoppingCartLoaded(products: products));
    } catch (e) {
      emit(ShoppingCartError(message: 'Failed to fetch products: $e'));
    }
  }

  void _mapAddProductToState(
      AddProduct event, Emitter<ShoppingCartState> emit) async {
    if (state is ShoppingCartLoaded) {
      //add image to firebase storage
      
      // Ensure the current state is of type ShoppingCartLoaded
      final List<ProductModule> updatedProducts =
          List.from((state as ShoppingCartLoaded).products)..add(event.product);

      // You can use repository to update the data in Firestore or any other storage
      try {
        await repository.addProduct(event.product,event.image);
        emit(ShoppingCartLoaded(products: updatedProducts));
      } catch (e) {
        emit(ShoppingCartError(message: 'Failed to add product: $e'));
      }
      // Emit the new state
    }
  }

  void _mapIncrementProductToState(
      IncrementProduct event, Emitter<ShoppingCartState> emit) async {
    final List<ProductModule> updatedProducts =
        (state.products as List<ProductModule?>)
            .map((product) {
              if (product != null && product.id == event.productId) {
                return product.copyWith(weight: product.weight + 1);
              }
              return product;
            })
            .whereType<ProductModule>()
            .toList();

    emit(ShoppingCartLoaded(products: updatedProducts));
  }

  void _mapDecrementProductToState(
    DecrementProduct event,
    Emitter<ShoppingCartState> emit,
  ) async {
    final List<ProductModule> updatedProducts =
        (state.products as List<ProductModule?>)
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

    emit(ShoppingCartLoaded(products: updatedProducts));
  }
}
