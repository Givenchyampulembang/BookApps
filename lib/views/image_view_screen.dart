import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class ImageViewScreen extends StatelessWidget {
  const ImageViewScreen({Key? key, required this.ImageUrl}) : super(key: key);

  final String ImageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.network(ImageUrl),
            BackButton(),
          ],
        ),
      ),
    );
  }
}
