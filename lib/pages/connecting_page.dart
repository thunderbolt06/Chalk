import 'package:chalk/pages/home_page.dart';
import 'package:chalk/sections/circles_painter.dart';
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
              painter: CirclesPainter(),
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
                'assets/startConnecting.png',
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
