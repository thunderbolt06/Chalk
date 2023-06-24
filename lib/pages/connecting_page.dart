import 'package:chalk/pages/home_page.dart';
import 'package:chalk/utils/on_tap_navigator.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'accepting_page.dart';
import '../utils/calculate_text_size.dart';
import '../utils/chalk_button.dart';
import '../main.dart';

class ConnectingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    var appState = context.watch<MyAppState>();
    var color = appState.color;
    TextStyle userNameStyle = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    Size userNameSize = calculateTextSize(
        text: 'Ameya Bhalerao', style: userNameStyle, context: context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: screenHeight / 2 - 100,
            right: screenWidth / 2 - 100,
            child: CustomPaint(
              size: Size(200, 200), // Set the desired size for the circles
              painter: CirclesPainter(color: color),
            ),
          ),
          Positioned(
            top: screenHeight / 2 -
                userNameSize.height / 2 -
                screenWidth / 4 -
                20,
            left: screenWidth / 2 - userNameSize.width / 2,
            child: Text('   Connecting...', style: userNameStyle),
          ),
          Positioned(
            top: screenHeight / 2 + screenWidth / 2 - 50,
            left: screenWidth / 2 - 50, // change to relative,
            child: ChalkButton(
              color: Colors.black,
              text: 'Cancel',
              next: MyHomePage(),
            ),
          ),
          Positioned(
            top: screenHeight / 2 - 50,
            left: screenWidth / 2 - 50, // change to relative,
            child: OnTapNavigator(
              next: AcceptingPage(),
              child: Image.asset(
                'startConnecting.png',
                width: 100,
                height: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CirclesPainter extends CustomPainter {
  Map<String, Color> color;
  CirclesPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius1 = size.width / 2;
    final radius2 = radius1 * 2;
    final radius3 = radius1 * 3;
    final radius4 = radius1 * 5;

    final paint1 = Paint()..color = color['one']!;
    final paint2 = Paint()..color = color['two']!;
    final paint3 = Paint()..color = color['three']!;
    final paint4 = Paint()..color = color['four']!;

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
