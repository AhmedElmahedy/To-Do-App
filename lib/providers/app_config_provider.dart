import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/firebase_utils.dart';
import '../home/model/task.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = "en";
  ThemeMode appTheme = ThemeMode.light;

  void changeLanguage(String newLanguage) async {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("code", appLanguage);
    notifyListeners();
  }

  Future<void> getLanguage() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    String code = preference.getString('code') ?? 'en';
    if (appLanguage == code) {
      return;
    }
    appLanguage = code;
  }

  Future<void> changeTheme(ThemeMode newTheme) async {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isdark', appTheme == ThemeMode.dark);
    notifyListeners();
  }

  Future<void> getTheme() async {
    final SharedPreferences preference = await SharedPreferences.getInstance();
    bool? isDark = preference.getBool('isdark');
    if (isDark != null) {
      if (isDark == true) {
        appTheme = ThemeMode.dark;
      } else {
        appTheme = ThemeMode.light;
      }
    }
    notifyListeners();
  }

  bool isDarkTheme() {
    return appTheme == ThemeMode.dark;
  }

  List<Task> tasksList = [];
  var selectDate = DateTime.now();

  void getAllTasksFromFireStore(String uid) async {
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.getTasksCollection(uid).get();
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    /// filter All Task => SelectDate
    tasksList = tasksList.where((task) {
      if (selectDate.day == task.dateTime.day &&
          selectDate.month == task.dateTime.month &&
          selectDate.year == task.dateTime.year) {
        return true;
      }
      return false;
    }).toList();

    /// Sorting task => select date
    tasksList.sort((task1, task2) {
      return task1.dateTime.compareTo(task2.dateTime);
    });
    notifyListeners();
  }

  void changeSelectDate(DateTime newSelectDate, String uid) {
    selectDate = newSelectDate;
    getAllTasksFromFireStore(uid);
    notifyListeners();
  }
}
