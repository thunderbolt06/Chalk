import 'package:chalk/provider.dart';
import 'package:chalk/sections/quick_picks_section.dart';
import 'package:chalk/sections/start_connecting_section.dart';
import 'package:chalk/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageBodySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

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
              Center(
                  child: Text(
                'Welcome, ${user?.email ?? 'Guest'}',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
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
