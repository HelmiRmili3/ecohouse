import 'package:ecohouse/core/features/auth/presentation/screens/auth_screen.dart';
import 'package:ecohouse/core/features/products/presentation/screens/products_shopping_screen.dart';
import 'package:ecohouse/core/features/shop/models/item.dart';
import 'package:ecohouse/core/features/shop/presentation/screens/shop.dart';
import 'package:ecohouse/core/features/shop/presentation/screens/shop_shopping_card.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  Routes.authScreen: (context) => const AuthScreen(),
  Routes.shoppingCard: (context) => const ProductShoppingScreen(),
  Routes.shop: (context) => const ShopScreen(),
  Routes.shopshoppingCard: (context) => ShopShoppingCard(
      items: ModalRoute.of(context)?.settings.arguments as List<ItemModule>)
};

class Routes {
  static const String authScreen = '/';
  static const String shoppingCard = '/shoppingcard';
  static const String shop = '/shop';
  static const String shopshoppingCard = '/shopshoppingCard';
}
