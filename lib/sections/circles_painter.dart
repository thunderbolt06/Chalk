import 'package:chalk/utils/colors.dart';
import 'package:flutter/material.dart';

class CirclesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius1 = size.width / 2;
    final radius2 = radius1 * 2;
    final radius3 = radius1 * 3;
    final radius4 = radius1 * 5;

    final paint1 = Paint()..color = MyColors.one;
    final paint2 = Paint()..color = MyColors.two;
    final paint3 = Paint()..color = MyColors.three;
    final paint4 = Paint()..color = MyColors.four;

    canvas.drawCircle(center, radius4, paint4);
    canvas.drawCircle(center, radius3, paint3);
    canvas.drawCircle(center, radius2, paint2);
    canvas.drawCircle(center, radius1, paint1);

    final chalkTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    );
    final chalkTextSpan = TextSpan(
      text: 'Chalk',
      style: chalkTextStyle,
    );
    final chalkTextPainter = TextPainter(
      text: chalkTextSpan,
      textDirection: TextDirection.ltr,
    );
    chalkTextPainter.layout();
    final chalkTextCenter = Offset(center.dx - chalkTextPainter.width / 2,
        center.dy - radius1 * 3.4 - chalkTextPainter.height / 2);
    chalkTextPainter.paint(canvas, chalkTextCenter);

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    );
    final textSpan = TextSpan(
      text: 'Chalk',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    final textCenter = Offset(center.dx - textPainter.width / 2,
        center.dy - radius1 * 3.4 - textPainter.height / 2);
    textPainter.paint(canvas, textCenter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
