// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class Avatart extends StatelessWidget {
//   const Avatart({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 115,
//       width: 115,
//       child: Stack(
//         clipBehavior: Clip.none,
//         fit: StackFit.expand,
//         children: [
//           CircleAvatar(
//             backgroundImage: AssetImage("assets/images/Profile Image.png"),
//           ),
//           Positioned(
//               right: -16,
//               bottom: 0,
//               child: SizedBox(
//                   height: 46,
//                   width: 46,
//                   child: FlatButton(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(50),
//                       side: BorderSide(color: Colors.white),
//                     ),
//                     color: Color(0xFFF5F6F9),
//                     onPressed: () {},
//                     // TODO: Icon not centered.
//                     child: Center(child: Icon(Icons.camera_alt_outlined)),
//                   )))
//         ],
//       ),
//     );
//   }
// }
