import 'package:chalk/sections/contacts_list_section.dart';
import 'package:chalk/utils/show_popup_android.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform;

Future<Widget> getContactsWithPermission() async {
  if (!Platform.isAndroid) {
    print("Platform is not android so no contacts support");
    return Text("Exception");
  } else {
    // Request permission to access contacts if not granted
    PermissionStatus permissionStatus = await Permission.contacts.request();

    if (permissionStatus.isGranted) {
      return getContacts();
    } else {
      return Text("Exception");
      // Handle the denied state
    }
  }
}

Future<Widget> getContacts() async {
  // Permission granted, retrieve contacts
  Iterable<Contact> contacts = await ContactsService.getContacts();

  List<String> contactNames = List.empty(growable: true);
  // Loop through the contacts and access their properties
  for (Contact contact in contacts) {
    String displayName = contact.displayName ?? '';

    contactNames.add(displayName);
  }

  return ContactsList(contacts: contactNames);
}
