import 'package:ecohouse/screens/login_screen_company.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/rounded_button.dart';

class ForgetPasswordScreenCompany extends StatelessWidget {
  const ForgetPasswordScreenCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16.0),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirme Password',
              ),
            ),
            const SizedBox(height: 16.0),
            RoundedButton(
              text: 'Confirme',
              onPressed: () => {},
              backgroundColor: Colors.lightGreen.shade300,
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Row(
                children: [
                  const Text("You have account ? "),
                  InkWell(
                    onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreenCompany(),
                        )),
                    child: const Text(
                      'login',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

class SocialMediaIcon extends StatelessWidget {
  final String iconPath;

  // ignore: use_key_in_widget_constructors
  const SocialMediaIcon({required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      width: 40.0,
      height: 40.0,
    );
  }
}
