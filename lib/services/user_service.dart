import 'dart:convert';
import 'package:acrilc/constants/env.dart';
import 'package:acrilc/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  // static UserData? _cachedUser;

  static void clearUserData() async {}

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
