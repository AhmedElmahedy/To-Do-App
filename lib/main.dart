import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/home/home_screen.dart';
import 'package:todoapp/home/task_list/edit_task.dart';
import 'package:todoapp/my_theme_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todoapp/providers/app_config_provider.dart';
void main ()async{
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
      await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey:"AIzaSyA4hTI8e1QKOem_PTuJKVh-n1OLauAU2-Y" ,
            appId: "com.example.todoapp",
            messagingSenderId: "261792930121",
            projectId: "todo-app-32e99"
        )
      ):
  await Firebase.initializeApp();
await FirebaseFirestore.instance.disableNetwork();


  runApp(ChangeNotifierProvider(
      create: (context) => AppConfigProvider(),
      child: MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(

      theme: MyThemeData.themeDataLight,
      darkTheme: MyThemeData.themeDataDark,
      themeMode: provider.appTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName ,
      routes: {
        HomeScreen.routeName : (context) => HomeScreen(),
        EditTask.routeName : (context) => EditTask()
      },
      locale: Locale(provider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
