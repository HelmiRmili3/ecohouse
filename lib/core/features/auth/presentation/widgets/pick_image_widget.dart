import 'dart:io';

import 'package:flutter/material.dart';

class PickImageWidget extends StatelessWidget {
  final File? image;

  const PickImageWidget({
    super.key,
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          image != null
              ? CircleAvatar(
                  radius: 60,
                  backgroundImage: FileImage(image!),
                )
              : const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/profile_avatar.jpg'),
                ),
          Positioned(
            bottom: 0,
            right: 0,
            width: 40,
            height: 40,
            child: ClipOval(
              child: Container(
                color: Colors.amber,
                child: const IconButton(
                  onPressed: null,
                  icon: Icon(Icons.camera),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
