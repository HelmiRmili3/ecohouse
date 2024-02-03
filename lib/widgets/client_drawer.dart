import 'package:ecohouse/screens/home_screen.dart';
import 'package:ecohouse/core/features/shopping/presentation/screens/home_screen_client.dart';
import 'package:ecohouse/screens/profile_screen_client.dart';
//import 'package:ecohouse/widgets/avatar.dart';
import 'package:ecohouse/widgets/elevaded_button_with_icon.dart';
import 'package:flutter/material.dart';

class ClientDrawer extends StatelessWidget {
  const ClientDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 179, 203, 223),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //const Avatart(),
                  ElevatedButtonWithIcon(
                    onPressed: () {},
                    icon: Icons.person, // Replace with the icon you want
                    label: 'Press Me',
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButtonWithIcon(
                    onPressed: () {},
                    icon: Icons.paid_outlined,
                    label: '90 POINTS',
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomeScreenClient()),
              );
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfileScreenClient()),
              );
            },
          ),
          const Divider(
            height: 500,
          ), // Add a divider before the logout button
          ListTile(
            title: const Center(child: Text('Logout')),
            onTap: () {
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
