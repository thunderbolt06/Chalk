import 'package:chalk/utils/colors.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  final List<String> contactNames;
  final List<Object> contactPhones;

  const ContactsList({required this.contactNames, required this.contactPhones});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 400,
      child: SingleChildScrollView(
        child: Container(
          width: 400,
          height: 500,
          child: ListView.builder(
            itemCount: contactNames.length,
            itemBuilder: (context, index) {
              final contactName =
                  contactNames[index].isEmpty ? "null" : contactNames[index];
              final contactPhone = contactPhones[index];
              return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: MyColors.one,
                    child: Text(
                      contactName.isEmpty ? "N" : contactName.substring(0, 1),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  title: Text(
                    contactName,
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  onTap: () {
                    // Handle contact item tap
                  },
                  subtitle: Text(
                    contactPhone.toString(),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
