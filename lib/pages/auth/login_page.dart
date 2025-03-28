import 'dart:convert';

import 'package:acrillic/constants/colors.dart';
import 'package:acrillic/constants/env.dart';
import 'package:acrillic/services/log_service.dart';
import 'package:acrillic/util.dart';
import 'package:acrillic/widgets/buttons.dart';
import 'package:acrillic/widgets/inputs.dart';
import 'package:acrillic/widgets/starting_bg.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _uuidController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final String apiUrl =
          "${ENV.baseUrl}/auth/login"; // Replace with actual hostname
      final Map<String, String> requestBody = {
        "email": _uuidController.text.trim(),
        "password": _passwordController.text.trim(),
      };

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(requestBody),
        );

        final responseData = tryEncodeJson(response.body);
        if (response.statusCode == 200) {
          // Store token in SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("jwt_token", responseData['token']);
          if (mounted) context.go("/app/home");

          // You can navigate to another screen here
        } else {
          // Handle login error
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Login Failed: ${responseData["msg"]}")),
            );
          }
        }
      } catch (e) {
        LogService.error(e.toString());
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("An error occurred. Please try again.")),
          );
        }
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppsBar(title: const Text('Login')),
      body: StartingBG(
        mainUI: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Welcome text
            SizedBox(height: 40),
            Text(
              "Welcome to Acrilc",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.primaryText,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "where art find its audience",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.primaryText,
              ),
            ),
            SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // UUID INPUT
                  formField("Email or Phone", _uuidController, false),
                  SizedBox(height: 10),
                  // Password Input
                  formField("Password", _passwordController, true),

                  // Submit Button
                  SizedBox(height: 20),
                  SizedBox(
                    width: 280,
                    child: Button(
                      disabled: isLoading,
                      onPressed: () {
                        _login();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text("Login", style: TextStyle(color: Colors.white)),
                          isLoading
                              ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                child: loader(size: 16),
                              )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget loader({double size = 20}) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          AppColor.primaryText,
        ), // Custom color
        strokeWidth: 2.0, // Thickness of the spinner
      ),
    );
  }

  Widget formField(
    String label,
    TextEditingController controller,
    bool isPassword,
  ) {
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          formLabel(label),
          InputField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
            controller: controller,
            hintText: '',
            isPassword: isPassword,
          ),
        ],
      ),
    );
  }

  Widget formLabel(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Text(text, style: TextStyle(color: AppColor.primaryText)),
    );
  }
}
