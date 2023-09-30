import 'dart:convert';

import 'package:chalk/services/api_service.dart';
import 'package:chalk/models/connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config.dart';
import '../provider.dart';
import 'contacts_list_section.dart';
import '../pages/contacts_page.dart';
import 'package:http/http.dart' as http;
import '../utils/chalk_button.dart';

class QuickPicksSection extends StatefulWidget {
  @override
  State<QuickPicksSection> createState() => _QuickPicksSectionState();
}

class _QuickPicksSectionState extends State<QuickPicksSection> {
  late List<String> contactNames = [
    'John Doe',
    'Jane Smith',
    'Michael Johnson',
    'Emily Davis',
    'Robert Brown',
  ];
  List<Connection> contacts = [];
  List<int> contactPhones = [1, 1, 1, 1, 1];

  @override
  void initState() {
    super.initState();

    refreshContacts(context);
  }

  Future<void> refreshContacts(context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.user == null) {
      return;
    }
    try {
      final response = await http.post(
        Uri.parse('${Config.CHALK_API_BASE_URL}/contacts/top'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'fromPhone': userProvider.user!.phone,
        }),
      );
      if (200 == response.statusCode) {
        contacts = parseContacts(response.body);
        contactNames = contacts.map((e) => e.toPhone).toList();
        contactPhones = contacts.map((e) => e.dist).toList();
        setState(() {});
      }
    } catch (e) {
      throw Exception(e);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quick Picks',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ChalkButton(
              color: Colors.black,
              text: "More",
              next: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactsPage(),
                  ),
                );
              },
            ),
            TextButton(
              onPressed: () {
                refreshContacts(context);
              },
              child: Text(
                'Refresh',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        SizedBox(
          height:
              2000.0, // Set a fixed height or use a value suitable for your layout
          child: ContactsList(
            contactNames: contactNames,
            contactPhones: contactPhones,
          ),
        ),
      ],
    );
  }
}
