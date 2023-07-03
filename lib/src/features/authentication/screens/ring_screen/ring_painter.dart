
import 'package:flutter/material.dart';



class RingsPainter extends CustomPainter {
  final double animationValue;

  RingsPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) + 3;
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1
      ..color = Color.fromARGB(255, 8, 95, 157).withOpacity(0.7);

      final ringPaintforcenter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(center, 40, ringPaintforcenter);
    


    final rippleRadius = radius * animationValue+20;

    final ripplePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Color.fromARGB(255, 4, 41, 86).withOpacity(0.2);

    canvas.drawCircle(center, rippleRadius, ripplePaint);

    for (int i = 0; i < 5; i++) {
      final ringRadius = (radius * (i + 1) / 5 )+i*i;
      canvas.drawCircle(center, ringRadius, ringPaint);
    }
    
  }
  
  @override
  bool shouldRepaint(RingsPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

