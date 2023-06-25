import 'package:chalk/utils/contacts_handler.dart';
import 'package:flutter/material.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: getContactsWithPermission(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Waiting");
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return snapshot.data!;
        }
      },
    );
  }
}
