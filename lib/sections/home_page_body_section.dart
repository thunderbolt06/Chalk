import 'package:chalk/sections/quick_picks_section.dart';
import 'package:chalk/sections/start_connecting_section.dart';
import 'package:chalk/utils/colors.dart';
import 'package:flutter/material.dart';

class HomePageBodySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [MyColors.two, Colors.white], // Set your desired colors here
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // AppHeader(),
              SizedBox(height: 16.0),
              Center(child: StartConnectingSection()),
              SizedBox(height: 30.0),
              QuickPicksSection(), // Add more widgets here as needed
            ],
          ),
        ),
      ),
    );
  }
}
