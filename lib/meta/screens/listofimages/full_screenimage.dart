import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String? imageUrl;

  const FullScreenImage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(
          imageUrl.toString(),
          fit: BoxFit.contain, // Image will scale to fit the screen
        ),
      ),
    );
  }
}
