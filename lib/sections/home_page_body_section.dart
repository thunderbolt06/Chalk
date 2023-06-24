import 'package:chalk/sections/quick_picks_section.dart';
import 'package:chalk/sections/start_connecting_section.dart';
import 'package:flutter/material.dart';

class HomePageBodySection extends StatelessWidget {
  const HomePageBodySection({
    super.key,
    required this.color,
  });

  final Map<String, Color> color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color['two']!, Colors.white], // Set your desired colors here
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
              QuickPicksSection(), // Add more widgets here as needed
            ],
          ),
        ),
      ),
    );
  }
}
