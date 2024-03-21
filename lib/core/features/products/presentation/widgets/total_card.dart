import 'package:flutter/material.dart';

class TotalCard extends StatelessWidget {
  final int weight;
  final int points;

  const TotalCard({
    Key? key,
    required this.weight,
    required this.points,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          const Text(
            "Total",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const Spacer(),
          Text(
            "Weight : $weight",
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          const Spacer(),
          Text(
            "Points : $points",
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
