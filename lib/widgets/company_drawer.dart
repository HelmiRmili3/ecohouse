import 'package:ecohouse/screens/home_screen_company.dart';
import 'package:ecohouse/screens/profile_screen_campany.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';

class CompanyDrawer extends StatelessWidget {
  const CompanyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Company',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomeScreenCompany()),
              );
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfileScreenCompany()),
              );
            },
          ),
          const Divider(
            height: 500,
          ), // Add a divider before the logout button
          ListTile(
            title: const Center(child: Text('Logout')),
            onTap: () {
              // Perform logout actions here
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
