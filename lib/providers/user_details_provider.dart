import 'package:flutter/material.dart';
import '../models/db_user_model.dart';

class UserDetailsProvider extends ChangeNotifier {
  UserData? _userData;

  UserData? get userData => _userData;

  void setUserData(UserData data) {
    // print("Setting user data: " + data.toString());
    _userData = data;
    notifyListeners();
  }
}