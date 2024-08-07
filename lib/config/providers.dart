
import 'package:ecohouse/core/features/shop/bloc/shop_bloc.dart';
import 'package:ecohouse/core/features/shop/repository/shop_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecohouse/core/features/auth/bloc/auth_bloc.dart';
import 'package:ecohouse/core/features/auth/repository/auth_repository.dart';
import 'package:ecohouse/core/features/products/bloc/shopping_card_bloc.dart';
import 'package:ecohouse/core/features/products/repository/shopping_card_repository.dart';
import 'package:ecohouse/core/features/user/bloc/user_bloc.dart';
import 'package:ecohouse/core/features/user/repository/user_repository.dart';
import 'package:ecohouse/core/features/orders/bloc/orders_bloc.dart';
import 'package:ecohouse/core/features/orders/repository/orders_repository.dart';

List<BlocProvider> getAppProviders() {
  return [
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(
        authRepository: AuthRepository(),
      ),
    ),
    BlocProvider<ShoppingCartBloc>(
      create: (context) => ShoppingCartBloc(
        repository: ShoppingCardRepository(),
      ),
    ),
    BlocProvider<UserBloc>(
      create: (context) => UserBloc(
        userRepository: UserRepository(),
      ),
    ),
    BlocProvider<OrdersBloc>(
      create: (context) => OrdersBloc(
        ordersRepository: OrdersRepository(),
      ),
    ),
    BlocProvider<ShopBloc>(
      create: (context) => ShopBloc(
        repository: ShopRepository(),
      ),
    ),
  ];
}
