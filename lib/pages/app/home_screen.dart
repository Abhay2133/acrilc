import 'package:acrillic/constants/colors.dart';
import 'package:acrillic/services/log_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> typeValues = ["All Types", "Paintings", "Crafting", "Other"];
  String typeValue = "";

  @override
  void initState() {
    super.initState();
    typeValue = typeValues.first;
  }

  void _onSearchChange(String value) {
    LogService.debug(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        searchBar(),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Container(
                height: 36.0,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: AppColor.secondary,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: DropdownButton<String>(
                  dropdownColor: AppColor.primary,
                  underline: SizedBox(height: 0),
                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                  value: typeValue,
                  items:
                      typeValues.map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: SizedBox(width: 80, child: Text(value)),
                        );
                      }).toList(),
                  onChanged: (String? val) {
                    if (val == null) return;
                    setState(() {
                      typeValue = val;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget searchBar() {
    return Padding(
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
    );
  }
}
