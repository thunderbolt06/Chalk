// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:math';

import 'package:chalk/pages/home_page.dart';
import 'package:chalk/sections/circles_painter.dart';
import 'package:chalk/utils/on_tap_navigator.dart';
import 'package:chalk/utils/show_popup_android.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart';

import 'package:provider/provider.dart';

import '../config.dart';
import '../provider.dart';
import '../sections/header_section.dart';
import '../services/api_service.dart';
import '../utils/colors.dart';
import 'accepting_page.dart';
import '../utils/calculate_text_size.dart';
import '../utils/chalk_button.dart';
import '../main.dart';

class SearchingPage extends StatelessWidget {
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
            child: Text('   Searching...', style: userNameStyle),
          ),
          Positioned(
            top: screenHeight / 2 + screenWidth / 2 - 100,
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
            top: screenHeight / 2 - 100,
            left: screenWidth / 2 - 50, // change to relative,
            child: GestureDetector(
              onTap: () async {
                if (sendToLogin(context)) {
                  return;
                }
                Provider.of<UserProvider>(context, listen: false)
                    .setStatus("searching");
                final user =
                    Provider.of<UserProvider>(context, listen: false).user;
                String? partner = await searchPartner(user);
                if (partner != null) {
                  Provider.of<UserProvider>(context, listen: false)
                      .setPartner(partner);

                  Provider.of<UserProvider>(context, listen: false)
                      .setStatus("accepting");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AcceptingPage(),
                    ),
                  );
                }
                // showPopup(context, Text(partner.toString()));
              },
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

  void onClickSearching() {}

  Future<String?> searchPartner(User? user) async {
    bool existingPartner = false;
    // searchExistingPartner();
    // check for existing connection with partner
    String partner;
    Response response1 = await get(
      Uri.parse(
          '${Config.CHALK_API_BASE_URL}/connection?fromPhone=${user?.phone}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response1.body);
    if (response1.statusCode == 200) {
      // found existing connection
      final results1 = json.decode(response1.body);
      if (results1['fromPhone'] != user?.phone) {
        partner = results1['fromPhone'];
      } else {
        partner = results1['toPhone'];
      }
      // return partner phone

      print("existing partner");
      print(partner);
      return partner;
    }

    // no existing partners

    // find new partner
    Response response = await get(
      Uri.parse('${Config.CHALK_API_BASE_URL}/status?status=searching'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final results = json.decode(response.body);
    print(results.toString());
    print(results.length);
    if (results.length < 2) {
      return null;
    }
    Random random = Random();
    var r = random.nextInt(results.length - 1);
    if (results[r]['phone'] == user?.phone) {
      if (r == results.length - 1) {
        r -= 1;
      } else {
        r += 1;
      }
    }
    partner = results[r]['phone'];
    // add connection
    Response response2 = await post(
      Uri.parse(
          '${Config.CHALK_API_BASE_URL}/connection?fromPhone=${user?.phone}&isActive=True&toPhone=$partner&fromStatus=validating&toStatus=validating'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response2.body);
    print("new partner");
    print(partner);
    return partner;
  }
}
