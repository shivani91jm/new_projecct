import 'package:flutter/material.dart';

class BezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50); // Starting point
    path.quadraticBezierTo(
      size.width / 2, // Control point x
      size.height,    // Control point y
      size.width,     // Ending point x
      size.height - 50, // Ending point y
    );
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}