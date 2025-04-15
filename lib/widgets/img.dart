import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Img extends StatelessWidget {
  final String lightImage;
  final String darkImage;
  final double? width;
  final double? height;
  final BoxFit fit;

  const Img({
    super.key,
    required this.lightImage,
    required this.darkImage,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (isDarkMode) {
      return darkImage.endsWith(".svg")
          ? SvgPicture.asset(darkImage, width: width, height: height, fit: fit)
          : Image.asset(darkImage, width: width, height: height, fit: fit);
    }

    return darkImage.endsWith(".svg")
        ? SvgPicture.asset(lightImage, width: width, height: height, fit: fit)
        : Image.asset(lightImage, width: width, height: height, fit: fit);
  }
}
