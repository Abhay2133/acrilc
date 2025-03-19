import 'package:flutter/material.dart';

class InputField extends TextFormField {
  InputField({
    super.key,
    required TextEditingController super.controller,
    required String hintText,
    bool isPassword = false,
    super.validator,
  }) : super(
          obscureText: isPassword,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white70),
            filled: true,
            fillColor: Colors.transparent, // Transparent background
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(200),
              borderSide: BorderSide(color: Color.fromARGB(166, 255, 255, 255), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(200),
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.red, width: 2), // Red border for errors
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
          ),
        );
}
