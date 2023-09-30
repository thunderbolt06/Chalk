import 'package:chalk/pages/login-form.dart';
import 'package:chalk/sections/header_section.dart';
import 'package:chalk/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:chalk/pages/home_page.dart';
import 'package:chalk/pages/signup-form.dart';
import 'package:chalk/provider.dart';
import 'package:chalk/sections/header_section.dart';
import 'package:flutter/material.dart';
import 'package:chalk/pages/contacts_page.dart';
import 'package:chalk/pages/logs_page.dart';
import 'package:chalk/sections/home_page_body_section.dart';
import 'package:chalk/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

import 'package:chalk/config.dart';

import '../utils/show_popup_android.dart';

class SignupForm extends StatefulWidget {
  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();

  Future<void> _signup(context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    final response = await http.post(
      Uri.parse('${Config.CHALK_API_BASE_URL}/accounts/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone': _phoneController.text,
        'name': _nameController.text,
        'password': _passwordController.text,
        'password2': _password2Controller.text,
      }),
    );

    if (response.statusCode < 400) {
      // If the server returns a 200 OK response, then parse the JSON.
      print('Signup successful');

      print(response.body);
      final user = User(
          phone: _phoneController.text, status: 'inactive', partner: "null");

      userProvider.setUser(user);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
      // Optionally navigate to another screen here
    } else {
      // If the server returns an unsuccessful response code, then throw an exception.
      print('Failed to signup');
      // print(response.body);
    }

    // showPopup(context, Text(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false, // Remove back button
            title: AppHeader(),
            backgroundColor: MyColors.two,
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    obscureText: true,
                    controller: _password2Controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // radius of 10
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 20), // padding inside button
                    ),
                    onPressed: () {
                      _signup(context);
                    },
                    child: Text('Signup'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginForm()),
                      );
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
