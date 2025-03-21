import 'package:flutter/material.dart';

class CircularTag extends StatelessWidget {
  final String label;
  const CircularTag({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFF242424), // Background color
        borderRadius: BorderRadius.circular(30), // Fully rounded shape
      ),
      child: Text(label, style: TextStyle(color: Colors.white70)),
    );
  }
}
