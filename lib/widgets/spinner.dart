import 'package:acrilc/constants/colors.dart';
import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  const Spinner({
    super.key,
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
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
}
