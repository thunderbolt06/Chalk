import 'package:chalk/pages/contacts_page.dart';
import 'package:chalk/pages/logs_page.dart';
import 'package:chalk/sections/home_page_body_section.dart';
import 'package:chalk/utils/colors.dart';
import 'package:flutter/material.dart';

import '../sections/bottom_nav_bar.dart';
import '../sections/header_section.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePageBodySection();
        break;
      case 1:
        page = LogsPage();
        break;
      case 2:
        page = ContactsPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    void onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
        print(selectedIndex);
      });
    }

    return Builder(builder: (context) {
      return LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false, // Remove back button
            title: AppHeader(),
            backgroundColor: MyColors.two,
          ),
          body: page,
          bottomNavigationBar: BottmNavBar(onItemTapped: onItemTapped),
        );
      });
    });
  }
}
