import 'package:ecohouse/screens/profile_screen_client.dart';
import 'package:flutter/material.dart';

AppBar buildCustomAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    title: const Text(
      'Ecohouse',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreenClient(),
                  ),
                );
              },
              child: Card(
                elevation: 5,
                child: Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(width: 5),
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage(
                          'assets/profile_avatar.jpg',
                        ), // Replace with your profile picture asset
                      ),
                      SizedBox(width: 10),
                      Center(
                        child: Text(
                          '\$ 2560',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
