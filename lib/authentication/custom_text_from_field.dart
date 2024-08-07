import 'package:flutter/material.dart';
import 'package:todoapp/app_color.dart';

typedef myValidator = String? Function(String?);

class CustomTextFromField extends StatelessWidget {
  String label;
  TextEditingController controller;
  myValidator validator;
  TextInputType keyboardType;
  bool obscureText;

  CustomTextFromField(
      {required this.label,
      required this.controller,
      required this.validator,
      this.keyboardType = TextInputType.text,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 2, color: AppColor.primaryColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 2, color: AppColor.primaryColor)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 2, color: AppColor.redColor)),
          errorMaxLines: 2,
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 2, color: AppColor.redColor)),
        ),
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscureText,
      ),
    );
  }
}
