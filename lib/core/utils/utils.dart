import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<File?> pickImage() async {
  File? image;
  final picker = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowCompression: true,
  );

  if (picker != null && picker.files.isNotEmpty) {
    image = File(picker.files.first.path!);
  }

  return image;
}

void showToast(message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}