import 'package:ecohouse/config/routes.dart';
import 'package:flutter/material.dart';

AppBar buildCustomAppBar(BuildContext context) {
  int shoppingItemCount = 3; // Replace with the actual shopping item count
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    centerTitle: true,
    title: const Text(
      'Ecohouse',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    actions: [
      IconButton(
        icon: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: SizedBox(
                height: 24,
                width: 24,
                child: Icon(
                  Icons.shopping_bag_outlined,
                  size: 40,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 20,
                  height: 20,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      '$shoppingItemCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.pushNamed(context, Routes.shoppingCard);
        },
      ),
    ],
  );
}
