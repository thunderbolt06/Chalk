import 'package:chalk/services/api_service.dart';
import 'package:chalk/utils/colors.dart';
import 'package:chalk/utils/on_tap_navigator.dart';
import 'package:flutter/material.dart';

import '../pages/connecting_page.dart';

class StartConnectingSection extends StatelessWidget {
  late String responseData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: ShapeDecoration(
            shape: CircleBorder(),
            color: MyColors.one,
          ),
          child: GestureDetector(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConnectingPage(),
                ),
              );
              // String data = await fetchHelloWorld();
              // print(data);
              print("tapped start connecting");
            },
            child: Image.asset(
              'assets/startConnecting.png', // Replace with your image path
              width: 150.0,
              height: 150.0,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          'Start Connecting',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
