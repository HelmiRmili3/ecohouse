import 'package:ecohouse/core/features/orders/presentation/screens/orders_screen_client.dart';
import 'package:ecohouse/core/features/shop/presentation/screens/products_screen_client.dart';
import 'package:ecohouse/screens/profile_screen_client.dart';
import 'package:flutter/material.dart';

class HomeScreenClient extends StatefulWidget {
  const HomeScreenClient({Key? key}) : super(key: key);

  @override
  State<HomeScreenClient> createState() => _HomeScreenClientState();
}

class _HomeScreenClientState extends State<HomeScreenClient> {
  int myCurrentIndex = 0;
  List pages = const [
    ProductScreenClient(),
    OrderScreenClient(),
    ProfileScreenClient(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: [],
        ),
        child: BottomNavigationBar(
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.grey,
            currentIndex: myCurrentIndex,
            onTap: (index) {
              setState(() {
                myCurrentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Orders",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: "Profile",
              ),
            ]),
      ),
      body: pages[myCurrentIndex],
      // body: ProductScreenClient(),
    );
  }
}
