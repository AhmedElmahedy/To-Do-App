import 'package:flutter/material.dart';
import 'package:todoapp/home/model/my_users.dart';

class UserProvider extends ChangeNotifier {
  MyUsers? currentUser;

  void upDateUser(MyUsers newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
