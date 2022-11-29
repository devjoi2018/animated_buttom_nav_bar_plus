import 'package:flutter/material.dart';

/// Dibuja la forma del nav bar por medio del CustomClipper
class NavBarPath extends CustomClipper<Path> {
  final double lowSize;
  final double bigSize;

  NavBarPath({
    this.lowSize = 0.2,
    this.bigSize = 1.0,
  });

  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(size.width * 0.29, 0);
    path.quadraticBezierTo(size.width * 0.35, 0, size.width * 0.38, size.height * lowSize);
    path.quadraticBezierTo(size.width * 0.50, size.height * bigSize, size.width * 0.62, size.height * lowSize);
    path.quadraticBezierTo(size.width * 0.65, 0, size.width * 0.71, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
