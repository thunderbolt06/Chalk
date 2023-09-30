import 'package:flutter/material.dart';

class User {
  String phone;
  String status;
  String partner;

  User({required this.phone, required this.status, required this.partner});
}

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setStatus(String status) {
    _user?.status = status;
    notifyListeners();
  }

  void setPartner(String partner) {
    _user?.partner = partner;
    notifyListeners();
  }
}
