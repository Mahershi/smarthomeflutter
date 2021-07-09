import 'package:flutter/material.dart';

class TopCurve extends CustomPainter{
  Color? myColor;
  TopCurve({this.myColor});
  @override
  void paint(Canvas canvas, Size size) {
    print(size.toString());
    final paint = Paint()
      ..color = myColor!
      ..style = PaintingStyle.fill;

    final path = new Path();
    path.moveTo(0, size.width * 0.4);
    // path.moveTo(size.width * 0.5, 0);
    // path.quadraticBezierTo(size.width * 0.7, size.width * 0.4, size.width, size.width * 0.4);
    path.cubicTo(size.width * 0.3, size.width*0.8, size.width * 0.5, size.width * 0.3, size.width, size.width * 0.7);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}



