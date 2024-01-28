import 'package:flutter/material.dart';

class ElevatedButtonWithIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  const ElevatedButtonWithIcon({super.key, 
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12), backgroundColor: Colors.blue, // Change the button color as needed
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: Colors.white, // Change the icon color as needed
          ),
          const SizedBox(width: 2), // Adjust the spacing between icon and label
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white, // Change the label color as needed
            ),
          ),
        ],
      ),
    );
  }
}
