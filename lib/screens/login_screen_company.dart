import 'package:ecohouse/screens/forget_password_screen_company.dart';
//import 'package:ecohouse/screens/home_screen_client.dart';
import 'package:ecohouse/screens/home_screen_company.dart';
import 'package:ecohouse/screens/signup_screen_company.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/rounded_button.dart';

class LoginScreenCompany extends StatelessWidget {
  const LoginScreenCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
            RoundedButton(
              text: 'Login',
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreenCompany(),
                ),
              ),
              backgroundColor: Colors.lightGreen.shade300,
            ),
            const SizedBox(height: 8.0),
            RoundedButton(
              text: 'Sign Up',
              backgroundColor: const Color.fromARGB(255, 154, 223, 255),
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUpScreenCompany(),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgetPasswordScreenCompany(),
                  )),
              child: const Text('Forgot Password?'),
            ),
            const SizedBox(height: 8.0),
            const Center(child: Text("Or")),
            const SizedBox(height: 8.0),
            RoundedButton(
                text: 'Sign Up With google',
                backgroundColor: Colors.yellow.shade300,
                onPressed: () => {}),
            const SizedBox(height: 16.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
