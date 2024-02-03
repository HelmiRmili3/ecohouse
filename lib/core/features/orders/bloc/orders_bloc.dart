import 'package:bloc/bloc.dart';
import 'package:ecohouse/core/features/orders/bloc/orders_events.dart';
import 'package:ecohouse/core/features/orders/bloc/orders_states.dart';
import 'package:ecohouse/core/features/orders/repository/orders_repository.dart';
import 'package:ecohouse/core/features/shopping/models/order.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepository ordersRepository;

  OrdersBloc({required this.ordersRepository}) : super(OrdersInitialState()) {
    // Register event handlers during initialization
    on<OrdersFetchEvent>(_mapOrdersFetchEventToState);
    on<OrderDeleteEvent>(_mapOrderDeleteToState);
  }

  void _mapOrdersFetchEventToState(
      OrdersFetchEvent event, Emitter<OrdersState> emit) async {
    emit(OrdersInitialState());
    try {
      List<OrderModule> orders = await ordersRepository.fetchOrders();
      emit(OrdersLoadedState(orders: orders));
    } catch (e) {
      emit(OrdersErrorState(error: e.toString()));
    }
  }

  void _mapOrderDeleteToState(
      OrderDeleteEvent event, Emitter<OrdersState> emit) async {
    //emit(OrdersInitialState());
    try {
      await ordersRepository.deleteOrder(event.id);
      List<OrderModule> orders = await ordersRepository.fetchOrders();
      emit(OrdersLoadedState(orders: orders));
    } catch (e) {
      emit(OrdersErrorState(error: e.toString()));
    }
  }
}
