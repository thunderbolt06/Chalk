import 'package:chalk/utils/colors.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  final List<String> contacts;

  const ContactsList({required this.contacts});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      width: 400,
      child: SingleChildScrollView(
        child: Container(
          width: 400,
          height: 1000,
          child: ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact =
                  contacts[index].isEmpty ? "null" : contacts[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: MyColors.one,
                  child: Text(
                    contact.isEmpty ? "N" : contact.substring(0, 1),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                title: Text(
                  contact,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                onTap: () {
                  // Handle contact item tap
                },
              );
            },
          ),
        ),
      ),
    );
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (context, index) => SizedBox(
        height: 10,
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
          title: Text(
            contact,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            // Handle contact item tap
          },
        );
      },
    );
  }
}
