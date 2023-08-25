import 'package:flutter/material.dart';

class User {
  final String email;
  // Add other user details here

  User({required this.email});
}

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
