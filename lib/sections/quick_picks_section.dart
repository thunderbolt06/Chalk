import 'package:flutter/material.dart';
import 'contacts_list_section.dart';
import '../pages/contacts_page.dart';
import '../utils/chalk_button.dart';

class QuickPicksSection extends StatelessWidget {
  final List<String> contacts = [
    'John Doe',
    'Jane Smith',
    'Michael Johnson',
    'Emily Davis',
    'Robert Brown',
  ];

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
              next: ContactsPage(),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        SizedBox(
          height:
              2000.0, // Set a fixed height or use a value suitable for your layout
          child: ContactsList(contacts: contacts),
        ),
      ],
    );
  }
}
