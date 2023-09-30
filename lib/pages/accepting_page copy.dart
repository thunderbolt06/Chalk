// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:chalk/pages/connected_page.dart';
import 'package:chalk/pages/searching_page.dart';
import 'package:chalk/pages/home_page.dart';
import 'package:chalk/utils/colors.dart';
import 'package:chalk/utils/on_tap_navigator.dart';
import 'package:chalk/utils/show_popup_android.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../config.dart';
import '../provider.dart';
import '../sections/header_section.dart';
import '../utils/calculate_text_size.dart';
import '../utils/chalk_button.dart';
import '../sections/circles_painter.dart';

class AcceptingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("welcome to accepting page");
    final user = Provider.of<UserProvider>(context, listen: false).user;
    final phone = user!.phone;
    final partner = user!.partner;
    print(user!.partner);
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    TextStyle userNameStyle = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    Size userNameSize = calculateTextSize(
        text: user.partner, style: userNameStyle, context: context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back button
        title: AppHeader(),
        backgroundColor: MyColors.two,
      ),
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
                100,
            left: screenWidth / 2 - userNameSize.width / 2,
            child: Text(user.partner, style: userNameStyle),
          ),
          Positioned(
            top: screenHeight / 2 + screenWidth / 4 - 60,
            left: screenWidth / 2 - 100, // change to relative,
            child: ChalkButton(
              color: MyColors.six,
              text: 'Next',
              next: () {
                Provider.of<UserProvider>(context, listen: false)
                    .setStatus("searching");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchingPage(),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: screenHeight / 2 + screenWidth / 4 - 60,
            left: screenWidth / 2 + 30, // change to relative,
            child: ChalkButton(
              color: MyColors.seven,
              text: 'Accept',
              next: () async {
                Provider.of<UserProvider>(context, listen: false)
                    .setStatus("validating");
                bool doCall = await hasAccepted(phone, partner);
                if (doCall) {
                  showPopup(context, Text("Connecting..."));
                  await Future.delayed(const Duration(seconds: 5));

                  callNumber(partner);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ),
                  );
                  Provider.of<UserProvider>(context, listen: false)
                      .setStatus("active");
                } else {
                  showPopup(context, Text("Waiting for user to connect..."));

                  await Future.delayed(const Duration(seconds: 2));

                  // bool denied = await hasAccepted(phone, partner);
                  bool denied = true;
                  if (denied) {
                    showPopup(
                        context, Text("Couldn't Connect. Searching more..."));
                    Provider.of<UserProvider>(context, listen: false)
                        .setStatus("active");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchingPage(),
                      ),
                    );
                  }
                }
              },
            ),
          ),
          Positioned(
            top: screenHeight / 2 + screenWidth / 2 - 50,
            left: screenWidth / 2 - 50, // change to relative,
            child: ChalkButton(
              color: Colors.black,
              text: 'Cancel',
              next: () {
                Provider.of<UserProvider>(context, listen: false)
                    .setStatus("active");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: screenHeight / 2 - 230,
            left: screenWidth / 2 - 150, // change to relative,
            child: Image.asset(
              'assets/startConnecting.png', // Replace with your image path
              width: 300,
              height: 400,
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> hasAccepted(phone, partner) async {
    Response response1 = await get(
      Uri.parse('${Config.CHALK_API_BASE_URL}/connection?fromPhone=$phone'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final result1 = json.decode(response1.body);
    print(result1);
    var from;
    var to;
    var fromStatus;
    var toStatus;
    if (result1['fromPhone'] == phone) {
      from = phone;
      to = partner;
      fromStatus = 'fromStatus';
      toStatus = 'toStatus';
    } else {
      to = phone;
      from = partner;
      fromStatus = 'toStatus';
      toStatus = 'fromStatus';
    }

    // we are assuming that fromStatus is for our user
    if (result1[toStatus] == 'validating') {
      // if the partner is validating
      // give him a call
      Response response2 = await post(
        Uri.parse(
            '${Config.CHALK_API_BASE_URL}/connection?fromPhone=$from&isActive=True&toPhone=$to&fromStatus=connected&toStatus=connected'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response2.body);
      return true;
    } else {
      Response response2 = await post(
        Uri.parse(
            '${Config.CHALK_API_BASE_URL}/connection?fromPhone=$phone&isActive=True&toPhone=$partner&$fromStatus=validating&$toStatus=accepting'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response2.body);
    }
    return false;
    // waiting for partner to accept
  }
}

callNumber(String phoneNumber) async {
  String number = phoneNumber;
  print("calling $number");
  await FlutterPhoneDirectCaller.callNumber(number);
}
