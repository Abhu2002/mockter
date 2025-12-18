import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;

class AuthenticationDetails extends ChangeNotifier {
  bool isLoggedIn;
  String name, mobile, email;

  AuthenticationDetails(
      {this.isLoggedIn = false,
      this.email = '',
      this.mobile = '',
      this.name = ''});

  void updateLogInStatus(
      bool updateValue, String email, String mobile, String name) {
    _auth.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        isLoggedIn = false;
      } else {
        print('User is signed in!');
        isLoggedIn = true;
      }
    });
    // isLoggedIn = updateValue;
    this.email = email;
    this.mobile = mobile;
    this.name = name;
    notifyListeners();
  }
}
