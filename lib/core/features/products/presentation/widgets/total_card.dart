import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TotalCard extends StatelessWidget {
  final int weight;
  final int points;

  const TotalCard({
    super.key,
    required this.weight,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 8.h),
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
