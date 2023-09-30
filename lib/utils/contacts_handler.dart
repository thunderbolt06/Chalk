import 'package:chalk/sections/contacts_list_section.dart';
import 'package:chalk/utils/show_popup_android.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform;
import 'dart:convert';

import 'package:chalk/api/top_contacts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config.dart';
import '../provider.dart';
import '../pages/contacts_page.dart';
import 'package:http/http.dart' as http;
import '../utils/chalk_button.dart';

Future<Widget> getContacts(context) async {
  List<String> contactNames = List.empty(growable: true);
  List<Object> contactPhones = List.empty(growable: true);
  Iterable<Contact> contacts = [];
  getContactsWithPermission().then((value) => {contacts = value});
  for (Contact contact in contacts) {
    String displayName = contact.displayName ?? '';
    Object phone = contact.phones ?? '';
    contactNames.add(displayName);
    contactPhones.add(phone);

    insertContacts(context, contact);
  }

  return ContactsList(contactNames: contactNames, contactPhones: contactPhones);
}

Future<Iterable<Contact>> getContactsWithPermission() async {
  if (!Platform.isAndroid) {
    print("Platform is not android so no contacts support");
    throw Exception("Exception");
  } else {
    // Request permission to access contacts if not granted
    PermissionStatus permissionStatus = await Permission.contacts.request();

    if (permissionStatus.isGranted) {
      // Permission granted, retrieve contacts
      Iterable<Contact> contacts = await ContactsService.getContacts();
      // Loop through the contacts and access their properties
      return contacts;
    } else {
      throw Exception("contacts denied");
      // Handle the denied state
    }
  }
}

void insertContacts(context, contact) async {
  var userProvider = Provider.of<UserProvider>(context, listen: false);
  if (userProvider.user == null) {
    return;
  }
  try {
    final response = await http.post(
      Uri.parse('${Config.CHALK_API_BASE_URL}/contacts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<Object>[
        {
          'fromPhone': userProvider.user!.phone,
          'toPhone': contact.phones.toString(),
          'dist': 1,
        }
      ]),
    );
    if (200 == response.statusCode) {
      print(response.body);
    }
  } catch (e) {
    throw Exception(e);
  }
}
