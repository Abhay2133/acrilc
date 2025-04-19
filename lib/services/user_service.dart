import 'dart:convert';
import 'package:acrilc/constants/env.dart';
import 'package:acrilc/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class UserService {
  static UserData? _cachedUser;

  static Future<UserData?> getCurrentUser() async {
    // Return cached user if available
    if (_cachedUser != null) {
      return _cachedUser;
    }

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token == null) {
      return null;
    }

    final response = await http.get(
      Uri.parse('${ENV.baseUrl}/api/user/me'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final userJson = data['data'];
      
      _cachedUser = UserData.fromJson(userJson);
      return _cachedUser;
    } else {
      // You can handle specific errors here
      return null;
    }
  }
}
