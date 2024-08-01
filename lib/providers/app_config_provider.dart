import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier{
 String appLanguage = "ar";
 ThemeMode appTheme =ThemeMode.dark;

 void changeTheme(ThemeMode newTheme){
   if (appTheme == newTheme){
     return ;
   }
   appTheme = newTheme;
   notifyListeners();
 }

 void changeLanguage(String newLanguage){
   if (appLanguage == newLanguage){
     return ;
   }
   appLanguage = newLanguage;
   notifyListeners();
 }
}