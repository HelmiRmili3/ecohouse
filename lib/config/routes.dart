
import 'package:ecohouse/core/features/auth/presentation/screens/auth_screen.dart';
import 'package:ecohouse/core/features/shop/presentation/screens/products_shopping_card.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  Routes.authScreen: (context) => const AuthScreen(),
  Routes.shoppingCard: (context) => const ProductShoppingCard()
};

class Routes {
  static const String authScreen = '/';
  static const String shoppingCard = '/shoppingcard';
}
