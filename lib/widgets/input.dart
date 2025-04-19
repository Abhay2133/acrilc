import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChange;
  final String placeholder;
  final double cornerRadius;
  final double padding;
  final Widget? prefixIcon;

  const Input({
    super.key,
    required this.searchController,
    required this.onSearchChange,
    this.placeholder = "Search art, artist, collections",
    this.cornerRadius = 12,
    this.padding = 20,
    this.prefixIcon = const Icon(Icons.search),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: TextFormField(
        controller: searchController,
        onChanged: onSearchChange, // Runs function on input change
        decoration: InputDecoration(
          filled: true,

          // fillColor: AppColor.secondary,
          hintText: placeholder,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
            borderSide: BorderSide.none, // Remove default border
          ),

          // Border when field is enabled
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(cornerRadius),
          //   borderSide: BorderSide(
          //     width: 2.0, // Adjust thickness
          //     color: Color(0x33000000), // Change color
          //   ),
          // ),

          // Border when field is focused
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
            borderSide: BorderSide(
              width: 3.0, // Thicker border on focus
              color: Color(0x331284de), // Change focus border color
            ),
          ),

          // Error border
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
            borderSide: BorderSide(
              width: 2.0,
              color: Colors.redAccent, // Error border color
            ),
          ),

          // Border when field has an error and is focused
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
            borderSide: BorderSide(
              width: 3.0,
              color: Color(0x661284de), // Error focus color
            ),
          ),
        ),
      ),
    );
  }
}
