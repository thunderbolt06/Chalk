import 'package:flutter/material.dart';

Size calculateTextSize({
  required String text,
  required TextStyle style,
  required BuildContext context,
}) {
  final double textScaleFactor = MediaQuery.of(context).textScaleFactor;

  final TextDirection textDirection = Directionality.of(context);

  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: textDirection,
    textScaleFactor: textScaleFactor,
  )..layout(minWidth: 0, maxWidth: double.infinity);

  return textPainter.size;
}
