// ignore: file_names
import 'package:flutter/material.dart';

PreferredSize buildCustomAppBar(
  BuildContext context,
  String title,
  int count,
  Function onPressed,
) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(kToolbarHeight),
    child: AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      actions: [
        IconButton(
          icon: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 40,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: 20,
                    height: 20,
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        "$count",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          onPressed: () {
            onPressed();
          },
        ),
      ],
    ),
  );
}
