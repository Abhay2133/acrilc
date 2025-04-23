import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

dynamic tryEncodeJson(String input) {
  try {
    return jsonDecode(input);
  } catch (e) {
    return input; // Return original string if decoding fails
  }
}

Color hexToColor(String hexString) {
  hexString = hexString.toUpperCase().replaceAll("#", "");
  if (hexString.length == 6) {
    hexString = "FF$hexString"; // Add alpha value (FF for full opacity)
  }
  return Color(int.parse(hexString, radix: 16));
}

void alert(
  BuildContext context,
  String text, {
  bool copy = false,
  String title = "Alert",
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, style: Theme.of(context).textTheme.headlineMedium),
        content: Text(text),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              copy
                  ? TextButton(
                    onPressed: () async {
                      Navigator.pop(context); // Close dialog
                      await Clipboard.setData(ClipboardData(text: text));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Copied to clipboard")),
                      );
                    },
                    child: Text(
                      "Copy",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                  : SizedBox(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                },
                child: Text(
                  "OK",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

Future<String?> getAuthToken() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('jwt_token');

  return token;
}

Future<bool> confirm({
  required BuildContext context,
  required String title,
  required String body,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(title, style: Theme.of(context).textTheme.headlineMedium),
        content: Text(body, style: Theme.of(context).textTheme.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(
              'Cancel',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              'Confirm',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      );
    },
  );

  return result ??
      false; // return false if dialog is dismissed without selection
}
