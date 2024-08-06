import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../home/firebase_utils.dart';
import '../home/model/task.dart';

class AppConfigProvider extends ChangeNotifier{
 String appLanguage = "en";
 ThemeMode appTheme =ThemeMode.light;
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
 bool isDarkTheme(){
   return appTheme == ThemeMode.dark;
 }

 List<Task> tasksList = [];
 var selectDate = DateTime.now();
 void getAllTasksFromFireStore()async {
   QuerySnapshot<Task> querySnapshot =
   await FirebaseUtils.getTasksCollection().get();
   tasksList = querySnapshot.docs.map((doc){
     return doc.data();
   }).toList();
   /// filter All Task => SelectDate
   tasksList = tasksList.where((task){
    if(selectDate.day == task.dateTime.day &&
        selectDate.month == task.dateTime.month &&
        selectDate.year == task.dateTime.year){
      return true;
    }
    return false;
   }).toList();

   /// Sorting task => select date
   tasksList.sort(( task1 , task2 ){
    return task1.dateTime.compareTo(task2.dateTime);
   });
   notifyListeners();
 }
 void changeSelectDate(DateTime newSelectDate){
   selectDate = newSelectDate;
   getAllTasksFromFireStore();
   notifyListeners();
 }


}