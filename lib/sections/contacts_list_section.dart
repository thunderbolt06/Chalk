import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  final List<String> contacts;

  const ContactsList({required this.contacts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: contacts.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey,
        height: 1.0,
      ),
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(
              contact.substring(0, 1),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(contact),
          onTap: () {
            // Handle contact item tap
          },
        );
      },
    );
  }
}
