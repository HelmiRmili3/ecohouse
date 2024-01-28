import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;

  // ignore: use_key_in_widget_constructors
  const RoundedButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.white, // Default color is red
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor, // Background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0), // Rounded corners
          // side: const BorderSide(width: 1.0, color: Colors.black), // Border
        ),
        minimumSize: const Size(300, 50), // Button size
      ),
      child: Text(text, style: const TextStyle(fontSize: 18)),
    );
  }
}
