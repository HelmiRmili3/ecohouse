import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/rounded_button.dart';
import 'login_screen_company.dart';

class SignUpScreenCompany extends StatelessWidget {
  const SignUpScreenCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 16.0),
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
                labelText: 'Confirme password',
              ),
            ),
            const SizedBox(height: 8.0),
            RoundedButton(
              text: 'Sign Up',
              backgroundColor: const Color.fromARGB(255, 154, 223, 255),
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreenCompany(),
                  )),
            ),
            const SizedBox(height: 16.0),
            const Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
            const SizedBox(height: 16.0),
            const Center(child: Text('or')),
            const SizedBox(height: 16.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                SocialMediaIcon(iconPath: 'assets/facebook.svg'),
                SizedBox(width: 16.0),
                SocialMediaIcon(iconPath: 'assets/twitter.svg'),
                SizedBox(width: 16.0),
                SocialMediaIcon(iconPath: 'assets/google.svg'),
              ],
            ),
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
