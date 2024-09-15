import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {
  final String? imageUrl;

  const FullScreenImage({super.key, this.imageUrl});

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ScaleTransition(
        scale: _animation,
        child: Center(
          child: Image.network(
            widget.imageUrl.toString(),
            fit: BoxFit.contain, // Image will scale to fit the screen
          ),
        ),
      ),
    );
  }
}
