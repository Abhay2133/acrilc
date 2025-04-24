import 'package:acrilc/constants/colors.dart';
import 'package:flutter/material.dart';

class InputField extends TextFormField {
  InputField({
    super.key,
    required TextEditingController super.controller,
    required String hintText,
    bool isPassword = false,
    super.style,
    super.validator,
  }) : super(
         obscureText: isPassword,
         decoration: InputDecoration(
           hintText: hintText,
           hintStyle: TextStyle(color: Colors.white70),
           filled: true,
           fillColor: Colors.transparent, // Transparent background
           enabledBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(200),
             borderSide: BorderSide(color: AppColor.primaryBorder, width: 2),
           ),
           focusedBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(200),
             borderSide: BorderSide(
               color: AppColor.primaryColor.withAlpha(100),
               width: 2,
             ),
           ),
           errorBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(50),
             borderSide: BorderSide(
               color: Colors.red,
               width: 2,
             ), // Red border for errors
           ),
           focusedErrorBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(50),
             borderSide: BorderSide(color: Colors.red, width: 2),
           ),
         ),
       );
}
