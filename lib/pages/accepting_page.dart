import 'package:chalk/pages/connected_page.dart';
import 'package:chalk/pages/connecting_page.dart';
import 'package:chalk/pages/home_page.dart';
import 'package:chalk/utils/colors.dart';
import 'package:chalk/utils/on_tap_navigator.dart';
import 'package:flutter/material.dart';

import '../utils/calculate_text_size.dart';
import '../utils/chalk_button.dart';
import '../sections/circles_painter.dart';

class AcceptingPage extends StatelessWidget {
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
            child: Text('Ameya Bhalerao', style: userNameStyle),
          ),
          Positioned(
            top: screenHeight / 2 + screenWidth / 4 - 20,
            left: screenWidth / 2 - 100, // change to relative,
            child: ChalkButton(
              color: MyColors.six,
              text: 'Next',
              next: ConnectingPage(),
            ),
          ),
          Positioned(
            top: screenHeight / 2 + screenWidth / 4 - 20,
            left: screenWidth / 2 + 30, // change to relative,
            child: OnTapNavigator(
                next: ConnectingPage(),
                child: ChalkButton(
                  color: MyColors.seven,
                  text: 'Accept',
                  next: ConnectedPage(),
                )),
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
            child: Image.asset(
              'assets/ameya-pic.png',
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
