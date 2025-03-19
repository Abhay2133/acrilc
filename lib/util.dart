import 'package:flutter/material.dart';
import 'dart:convert';

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

void alert(BuildContext context, String text, [String title = "Alert"]) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            child: Text("OK", style: Theme.of(context).textTheme.bodyMedium,),
          ),
        ],
      );
    },
  );
}
