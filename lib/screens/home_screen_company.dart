import 'package:ecohouse/widgets/company_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreenCompany extends StatelessWidget {
  const HomeScreenCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: const Center(child: Text("company home page")),
      drawer: const CompanyDrawer(),
    );
  }
}
