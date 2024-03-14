import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PhotoPreview extends StatelessWidget {
  PhotoPreview({super.key, required this.image});
  XFile image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Image.file(File(image.path)),
    );
  }
}
