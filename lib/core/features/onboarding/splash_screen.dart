// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/material.dart';

// import 'onbording_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   SplashScreenState createState() => SplashScreenState();
// }

// class SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(
//         const Duration(seconds: 10),
//         () => Navigator.pushReplacement(context,
//             MaterialPageRoute(builder: (context) => const OnbordingScreen())));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color.fromARGB(255, 5, 46, 7),
//         body: Column(
//           children: [
//             SizedBox(
//                 height: MediaQuery.of(context).size.height,
//                 child: Stack(
//                   children: [
//                     Align(
//                       alignment: const AlignmentDirectional(3, -0.3),
//                       child: Container(
//                         height: 300,
//                         width: 300,
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.deepPurple,
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: const AlignmentDirectional(-3, -0.3),
//                       child: Container(
//                         height: 300,
//                         width: 300,
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Color(0xFF673AB7),
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: const AlignmentDirectional(0, -1.2),
//                       child: Container(
//                         height: 300,
//                         width: 600,
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.rectangle,
//                           color: Color(0xFFFFAB40),
//                         ),
//                       ),
//                     ),
//                     BackdropFilter(
//                       filter: ImageFilter.blur(
//                         sigmaX: 100.0,
//                         sigmaY: 100.0,
//                       ),
//                       child: Container(
//                         decoration: const BoxDecoration(
//                           color: Colors.transparent,
//                         ),
//                       ),
//                     ),
//                     Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.asset(
//                             'assets/logo.png',
//                             width: 400,
//                             height: 800,
//                           ),
//                           const SizedBox(height: 20),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//           ],
//         ));
//   }
// }
