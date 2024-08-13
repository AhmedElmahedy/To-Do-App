import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/app_color.dart';
import 'package:todoapp/authentication/custom_text_from_field.dart';
import 'package:todoapp/dialog_utils.dart';
import 'package:todoapp/home/firebase_utils.dart';
import 'package:todoapp/home/home_screen.dart';
import 'package:todoapp/home/model/my_users.dart';

import '../../providers/user_provider.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'Register Screen';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
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
            'Create Account',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /// Enter user name
                    CustomTextFromField(
                      label: 'User Name',
                      controller: nameController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter User Name .';
                        }
                        return null;
                      },
                    ),

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

                    /// Enter Password
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

                    /// Enter Confirm Password
                    CustomTextFromField(
                      label: 'Confirm Password',
                      controller: passwordConfirmController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Confirm Password .';
                        }
                        if (text != passwordController.text) {
                          return "Confirm Password Doesn't Match Password. ";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),

                    /// Icon Create Account
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: ElevatedButton(
                          onPressed: () {
                            register(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Create Account',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: AppColor.primaryColor),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: AppColor.primaryColor,
                                size: 30,
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }

  void register(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      /// register
      // todo: show Loading...
      DialogUtils.showLoading(context: context, massage: 'Loading....');
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUsers myUsers = MyUsers(
            id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text);
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.upDateUser(myUsers);
        await FirebaseUtils.addUserToFireStore(myUsers);

        /// todo: hide loading..
        DialogUtils.hideLoading(context: context);

        /// todo: show loading..
        DialogUtils.showMassage(
            context: context,
            content: 'Register Successfully',
            title: 'Success',
            posActionName: 'ok',
            posAction: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            });
        print('register successfully');
        print(credential.user?.uid ?? 'null');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          /// todo: hide loading..
          DialogUtils.hideLoading(context: context);

          /// todo: show loading..
          DialogUtils.showMassage(
              context: context,
              content: 'The password provided is too weak',
              title: 'Error',
              posActionName: 'ok');
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          /// todo: hide loading..
          DialogUtils.hideLoading(context: context);

          /// todo: show loading..
          DialogUtils.showMassage(
              context: context,
              content: 'The account already exists for that email.',
              title: 'Error',
              posActionName: 'ok');
          print('The account already exists for that email.');
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
