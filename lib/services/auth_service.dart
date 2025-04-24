import 'dart:convert';

import 'package:acrilc/constants/env.dart';
import 'package:acrilc/util.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<bool> doLogin(
    String email,
    String password, {
    void Function(http.Response?)? onFail,
    void Function(Object?)? onError,
  }) async {
    try {
      final String apiUrl =
          "${ENV.baseUrl}/auth/login"; // Replace with actual hostname
      final Map<String, String> requestBody = {
        "email": email,
        "password": password,
      };
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
        return true;

        // You can navigate to another screen here
      } else {
        if (onFail != null) onFail(response);
        return false;
      }
    } catch (e) {
      if (onError != null) onError(e);
      return false;
    }
  }

  static Future<bool> doSignup({
    String email = "",
    String password = "",
    String fullName = "",
    void Function(http.Response)? onSuccess,
    void Function(http.Response)? onFail,
  }) async {
    final String apiUrl =
        "${ENV.baseUrl}/auth/signup"; // Replace with actual hostname
    final Map<String, String> requestBody = {
      "fullName": fullName,
      "email": email,
      "password": password,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );

    final responseData = tryEncodeJson(response.body);
    if (response.statusCode == 201) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("jwt_token", responseData['token']);

      if (onSuccess != null) onSuccess(response);
      return true;
    } else {
      if (onFail != null) onFail(response);
      return false;
    }
  }

  static Future<void> doLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
