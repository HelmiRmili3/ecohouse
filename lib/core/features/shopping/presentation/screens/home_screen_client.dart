import 'package:ecohouse/core/features/shopping/presentation/screens/orders_screen_client.dart';
import 'package:ecohouse/core/features/shopping/presentation/screens/products_screen_client.dart';
import 'package:ecohouse/screens/profile_screen_client.dart';
import 'package:flutter/material.dart';

class HomeScreenClient extends StatefulWidget {
  const HomeScreenClient({Key? key}) : super(key: key);

  @override
  State<HomeScreenClient> createState() => _HomeScreenClientState();
}

class _HomeScreenClientState extends State<HomeScreenClient> {
  // int myCurrentIndex = 0;
  // List pages = const [
  //   ProductScreenClient(),
  //   OrderScreenClient(),
  //   ProfileScreenClient(),
  // ];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // bottomNavigationBar: Container(
      //   margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      //   decoration: BoxDecoration(boxShadow: [
      //     BoxShadow(
      //         color: Colors.black.withOpacity(0.5),
      //         blurRadius: 25,
      //         offset: const Offset(8, 20))
      //   ]),
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(30),
      //     child: BottomNavigationBar(
      //          //backgroundColor: Colors.transparent,
      //         selectedItemColor: Colors.blueAccent,
      //         unselectedItemColor: Colors.black,
      //         currentIndex: myCurrentIndex,
      //         onTap: (index) {
      //           setState(() {
      //             myCurrentIndex = index;
      //           });
      //         },
      //         items: const [
      //           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      //           BottomNavigationBarItem(
      //               icon: Icon(Icons.settings), label: "Orders"),
      //           BottomNavigationBarItem(
      //               icon: Icon(Icons.person_outline), label: "Profile"),
      //         ]),
      //   ),
      // ),
      //body: pages[myCurrentIndex],
      body: ProductScreenClient(),
    );
  }
}
