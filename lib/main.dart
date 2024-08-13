import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/authentication/login/login_screen.dart';
import 'package:todoapp/authentication/register/register_screen.dart';
import 'package:todoapp/home/home_screen.dart';
import 'package:todoapp/home/task_list/edit_task.dart';
import 'package:todoapp/my_theme_data.dart';
import 'package:todoapp/providers/app_config_provider.dart';
import 'package:todoapp/providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: "AIzaSyA4hTI8e1QKOem_PTuJKVh-n1OLauAU2-Y",
              appId: "com.example.todoapp",
              messagingSenderId: "261792930121",
              projectId: "todo-app-32e99"))
      : await Firebase.initializeApp();
  //await FirebaseFirestore.instance.disableNetwork();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => AppConfigProvider()
              ..getLanguage()
              ..getTheme()),
        ChangeNotifierProvider(create: (context) => UserProvider())
      ],
      child: MyApp(),
    ),

    // ChangeNotifierProvider(
    // create: (context) => AppConfigProvider()
    //   ..getLanguage()
    //   ..getTheme(),
    // child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  late AppConfigProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.themeDataLight,
      darkTheme: MyThemeData.themeDataDark,
      themeMode: provider.appTheme,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        EditTask.routeName: (context) => EditTask(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen()
      },
      locale: Locale(provider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
