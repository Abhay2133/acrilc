import 'package:acrillic/constants/colors.dart';
import 'package:acrillic/services/log_service.dart';
import 'package:acrillic/widgets/inputs.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  void _onSearchChange(String value) {
    LogService.debug(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            controller: _searchController,
            onChanged: _onSearchChange, // Runs function on input change
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.secondary,
              hintText: "Search art, artist, collections",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none, // Remove default border
              ),

              // Border when field is enabled
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 2.0, // Adjust thickness
                  color: Color(0x55000000), // Change color
                ),
              ),

              // Border when field is focused
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 3.0, // Thicker border on focus
                  color: Color(0x331284de), // Change focus border color
                ),
              ),

              // Error border
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 2.0,
                  color: Colors.redAccent, // Error border color
                ),
              ),

              // Border when field has an error and is focused
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 3.0,
                  color: Color(0x661284de), // Error focus color
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
