import 'package:flutter/material.dart';

enum UserRole { user, admin }

class Auth extends ChangeNotifier {
  UserRole _role = UserRole.user;
  String _name = 'Ade Setiawan';
  String _email = 'ade99setia@example.com';
  bool _loggedIn = false;

  UserRole get role => _role;
  String get name => _name;
  String get email => _email;
  bool get loggedIn => _loggedIn;
  bool get isAdmin => _role == UserRole.admin;

  void login(String email, UserRole role) {
    _email = email;
    _role = role;
    _name = role == UserRole.admin ? 'Admin Toko' : 'Ade Setiawan';
    _loggedIn = true;
    notifyListeners();
  }

  void register(String name, String email) {
    _name = name;
    _email = email;
    _role = UserRole.user;
    _loggedIn = true;
    notifyListeners();
  }

  void logout() {
    _loggedIn = false;
    notifyListeners();
  }
}
