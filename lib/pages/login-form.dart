import 'package:chalk/pages/home_page.dart';
import 'package:chalk/pages/signup-form.dart';
import 'package:chalk/provider.dart';
import 'package:chalk/sections/header_section.dart';
import 'package:chalk/utils/show_popup_android.dart';
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

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login(context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    final response = await http.post(
      Uri.parse('${Config.CHALK_API_BASE_URL}/accounts/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone': _phoneController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      print('Login successful');
      // final userDetails = jsonDecode(response.body);
      // final user = User(phone: userDetails['phone']);
      final user = User(
          phone: _phoneController.text, status: 'inactive', partner: "null");

      userProvider.setUser(user);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } else {
      print('Failed to login');
    }
    showPopup(context, Text(response.body));
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
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: MyColors.two,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // radius of 10
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 20), // padding inside button
                      ),
                      onPressed: () {
                        _login(context);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupForm()),
                        );
                      },
                      child: Text(
                        'Signup',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
