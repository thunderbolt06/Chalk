import 'package:flutter/material.dart';

class User {
  final String phone;

  User({required this.phone});
}

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
