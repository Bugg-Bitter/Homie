import 'package:flutter/material.dart';

class DrawUpTriangleShape extends CustomPainter {
  Paint painter = Paint();

  DrawUpTriangleShape() {
    painter = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    path.moveTo(size.width / 2, 4);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
