import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecohouse/core/features/orders/bloc/orders_events.dart';
import 'package:ecohouse/core/features/orders/bloc/orders_states.dart';
import 'package:ecohouse/core/features/orders/repository/orders_repository.dart';
import 'package:ecohouse/core/features/products/models/sell_order.dart';
import 'package:ecohouse/core/features/shop/models/buy_order.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final OrdersRepository ordersRepository;

  final _sellOrdersController =
      StreamController<List<SellOrderModule>>.broadcast();
  final _buyOrdersController =
      StreamController<List<BuyOrderModule>>.broadcast();

  Stream<List<BuyOrderModule>> get buyordersStream =>
      _buyOrdersController.stream;
  Stream<List<SellOrderModule>> get sellordersStream =>
      _sellOrdersController.stream;

  Stream<User?> getAuthStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  OrdersBloc({required this.ordersRepository}) : super(OrdersInitialState()) {
    getAuthStateChanges().listen((user) {
      if (user != null) {
        final userId = user.uid;

        ordersRepository.fetchBuyOrders().listen((orders) {
          final userOrders =
              orders.where((order) => order.customerId == userId).toList();
          _buyOrdersController.add(userOrders);
        });

        ordersRepository.fetchSellOrders().listen((orders) {
          final userOrders =
              orders.where((order) => order.customerId == userId).toList();
          _sellOrdersController.add(userOrders);
        });
      }
    });
    // on<OrdersFetchEvent>(_mapOrdersFetchEventToState);
    // on<OrderDeleteEvent>(_mapOrderDeleteToState);
  }

  // void _mapOrdersFetchEventToState(
  //     OrdersFetchEvent event, Emitter<OrdersState> emit) async {
  //   emit(OrdersInitialState());
  //   try {
  //     List<OrderModule> orders = await ordersRepository.fetchOrders();
  //     emit(OrdersLoadedState(orders: orders));
  //   } catch (e) {
  //     emit(OrdersErrorState(error: e.toString()));
  //   }
  // }

  // void _mapOrderDeleteToState(
  //     OrderDeleteEvent event, Emitter<OrdersState> emit) async {
  //   emit(OrdersInitialState());
  //   try {
  //     await ordersRepository.deleteOrder(event.id);
  //     List<OrderModule> orders = await ordersRepository.fetchOrders();
  //     emit(OrdersLoadedState(orders: orders));
  //   } catch (e) {
  //     emit(OrdersErrorState(error: e.toString()));
  //   }
  // }
  @override
  Future<void> close() {
    _buyOrdersController.close();
    _sellOrdersController.close();
    return super.close();
  }
}
