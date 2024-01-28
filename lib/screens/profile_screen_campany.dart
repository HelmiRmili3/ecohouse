import 'package:flutter/material.dart';

class ProfileScreenCompany extends StatelessWidget {
  const ProfileScreenCompany({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(child: Text("company profile")),
    );
  }
}

