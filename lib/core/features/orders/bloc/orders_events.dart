import 'package:equatable/equatable.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();
}

class OrdersFetchEvent extends OrdersEvent {
  @override
  List<Object?> get props => [];
}

class OrderDeleteEvent extends OrdersEvent {
  final String id;

  const OrderDeleteEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class OrderEditEvent extends OrdersEvent {
  @override
  List<Object?> get props => [];
}
