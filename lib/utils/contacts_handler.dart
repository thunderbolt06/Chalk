import 'package:chalk/sections/contacts_list_section.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../config.dart';
import '../provider.dart';
import 'package:http/http.dart' as http;

import '../services/api_service.dart';

Future<Widget> getContactsWithPermission(context) async {
  sendToLogin(context);
  if (!Platform.isAndroid) {
    print("Platform is not android so no contacts support");
    return Text("Exception");
  } else {
    // Request permission to access contacts if not granted
    PermissionStatus permissionStatus = await Permission.contacts.request();

    if (permissionStatus.isGranted) {
      return getContacts(context);
    } else {
      return Text("Exception");
      // Handle the denied state
    }
  }
}

Future<Widget> getContacts(context) async {
  // Permission granted, retrieve contacts
  Iterable<Contact> contacts = await ContactsService.getContacts();

  List<String> contactNames = List.empty(growable: true);
  List<String> contactPhones = List.empty(growable: true);
  // Loop through the contacts and access their properties
  for (Contact contact in contacts) {
    String displayName = contact.displayName ?? '';
    List<Item>? phone = contact.phones;
    contactNames.add(displayName);
    // contactPhones.add("value");
    // if (phone != null && phone[0].value != null) {
    // var num = "null";
    // num = phone?[0].value ?? "null";
    if (phone!.isNotEmpty) {
      String ph = phone[0].value ?? "null";
      ph = ph.replaceAll('-', '');
      ph = ph.replaceAll(' ', '');
      if (ph[0] == '+') {
        ph = ph.substring(3);
      }
      contactPhones.add(ph);
      insertContacts(context, ph);
    } else {
      contactPhones.add("0");
    }
  }

  return ContactsList(contactNames: contactNames, contactPhones: contactPhones);
}

void insertContacts(context, contactPhones) async {
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
      body: jsonEncode(<String, String>{
        'fromPhone': userProvider.user!.phone,
        'toPhone': contactPhones,
        'dist': "1",
      }),
    );
    print(response.body);
    if (200 == response.statusCode) {
      print("inserted contacts");
    }
  } catch (e) {
    throw Exception(e);
  }
}
