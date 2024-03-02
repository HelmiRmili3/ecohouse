//states
import 'package:ecohouse/core/features/shop/models/order.dart';
import 'package:equatable/equatable.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();
}

//init state
class OrdersInitialState extends OrdersState {
  @override
  List<Object?> get props => [];
}

// signed in state
class OrdersLoadedState extends OrdersState {
  final List<OrderModule> orders;

  const OrdersLoadedState({required this.orders});
  @override
  List<Object?> get props => [orders];
}

// error state
class OrdersErrorState extends OrdersState {
  final String error;

  const OrdersErrorState({required this.error});

  @override
  List<Object?> get props => [];
}
