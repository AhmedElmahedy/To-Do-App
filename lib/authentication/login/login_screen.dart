import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/app_color.dart';
import 'package:todoapp/authentication/custom_text_from_field.dart';
import 'package:todoapp/home/home_screen.dart';

import '../../dialog_utils.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'Login Screen';

  TextEditingController emailController =
      TextEditingController(text: 'ahmed@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      /// background page
      Container(
        color: AppColor.backgroundLightColor,
        child: Image.asset(
          'assets/images/background_register.png',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Login',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),

              /// Text Welcome back
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Welcome back!",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      /// Enter Email
                      CustomTextFromField(
                        label: 'Email',
                        controller: emailController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter Email .';
                          }
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text);
                          if (!emailValid) {
                            return 'Please Enter Valid Email';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),

                      /// Enter password
                      CustomTextFromField(
                        label: 'Password',
                        controller: passwordController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter Password .';
                          }
                          if (text.length < 6) {
                            return 'Please Should Be at Least 6 Chars';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),

                      /// forgot password
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: GestureDetector(
                          child: Text(
                            'Forgot Password?',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),

                      /// icon login
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: ElevatedButton(
                            onPressed: () {
                              login(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primaryColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Login',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: AppColor.whiteColor),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: AppColor.whiteColor,
                                  size: 30,
                                )
                              ],
                            )),
                      ),

                      /// create my Account
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: GestureDetector(
                          child: Text(
                            'Or Create My Account',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                context, RegisterScreen.routeName);
                          },
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    ]);
  }

  void login(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      /// register
      // todo: show Loading...
      DialogUtils.showLoading(context: context, massage: 'Waiting....');
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        /// todo: hide loading..
        DialogUtils.hideLoading(context: context);

        /// todo: show loading..
        DialogUtils.showMassage(
            context: context,
            content: 'Login Successfully',
            title: 'Success',
            posActionName: 'ok',
            posAction: () {
              Navigator.pushNamed(context, HomeScreen.routeName);
            });
        print("login successfully");
        print(credential.user?.uid ?? 'null');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          /// todo: hide loading..
          DialogUtils.hideLoading(context: context);

          /// todo: show loading..
          DialogUtils.showMassage(
              context: context,
              content:
                  'The supplied auth credential is incorrect, malformed or has expired.',
              title: 'Error',
              posActionName: 'ok');
          print(
              'The supplied auth credential is incorrect, malformed or has expired.');
        } else if (e.code == 'network-request-failed') {
          /// todo: hide loading..
          DialogUtils.hideLoading(context: context);

          /// todo: show loading..
          DialogUtils.showMassage(
              context: context,
              content:
                  ' A network error (such as timeout, interrupted connection or unreachable host) has occurred.',
              title: 'Error',
              posActionName: 'ok');
          print(
              ' A network error (such as timeout, interrupted connection or unreachable host) has occurred.');
        }
      } catch (e) {
        /// todo: hide loading..
        DialogUtils.hideLoading(context: context);

        /// todo: show loading..
        DialogUtils.showMassage(
            context: context,
            content: e.toString(),
            title: 'Error',
            posActionName: 'ok');
        print(e);
      }
    }
  }
}
