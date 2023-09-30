import 'dart:convert';

import 'package:chalk/models/connection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../config.dart';
import '../provider.dart';

Future<http.Response> getTopContacts(context) async {
  var userProvider = Provider.of<UserProvider>(context, listen: false);
  try {
    final response = await http.post(
      Uri.parse('${Config.CHALK_API_BASE_URL}/contacts/top'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'fromPhone': userProvider.user.toString(),
      }),
    );
    return response;
  } catch (e) {
    throw Exception(e);
  }
}

List<Connection> parseContacts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Connection>((json) => Connection.fromJson(json)).toList();
}
