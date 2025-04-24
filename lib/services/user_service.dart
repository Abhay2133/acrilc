import 'dart:convert';
import 'package:acrilc/constants/env.dart';
import 'package:acrilc/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  // static UserData? _cachedUser;

  static Future<void> clearUserData() async {}

  static Future<Map<String, dynamic>?> getUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    String? userData = prefs.getString("user-profile-$userId");
    if (userData != null) {
      Map<String, dynamic> data = jsonDecode(userData);
      return data;
    }

    final response = await http.get(
      Uri.parse('${ENV.baseUrl}/api/user/$userId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final userJson = data['data'];
      prefs.setString("user-profile-$userId", jsonEncode(userJson));
      // UserData user = UserData.fromJson(userJson);
      return userJson;
    } else {
      // You can handle specific errors here
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getAllFortes() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('all-fortes');
    if (data != null) {
      return jsonDecode(data);
    }
    final response = await http.get(Uri.parse("${ENV.baseUrl}/general/fortes"));
    if (response.statusCode < 400) {
      prefs.setString('all-fortes', response.body);
      return jsonDecode(response.body);
    }
    return null;
  }

  static Future<UserData?> getCurrentUser() async {
    // Return cached user if available

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    String? userData = prefs.getString("user-profile");
    if (userData != null) {
      Map<String, dynamic> data = jsonDecode(userData);
      UserData user = UserData.fromJson(data);
      return user;
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
      prefs.setString("user-profile", jsonEncode(userJson));
      UserData user = UserData.fromJson(userJson);
      return user;
    } else {
      // You can handle specific errors here
      return null;
    }
  }
}
