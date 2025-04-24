import 'package:acrilc/constants/colors.dart';
import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  const Spinner({super.key, required this.size, this.color, this.stroke});

  final double size;
  final Color? color; // = AppColor.primaryColor;
  final double? stroke;

  @override
  Widget build(BuildContext context) {
    Color spinnerColor = color ?? AppColor.primaryColor;
    double spinnerStroke = stroke ?? 2.0;
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(spinnerColor), // Custom color
        strokeWidth: spinnerStroke, // Thickness of the spinner
      ),
    );
  }
}
