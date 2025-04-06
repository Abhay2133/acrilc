import 'package:acrillic/constants/colors.dart';
import 'package:acrillic/services/log_service.dart';
import 'package:acrillic/widgets/post_container.dart';
import 'package:acrillic/widgets/zoomable_image.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          searchBar(),
          SizedBox(height: 10),
          OptionsRow(typeValues: typeValues),
          SizedBox(height: 10),
          PostContainer(),
        ],
      ),
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

class OptionsRow extends StatefulWidget {
  final List<String> typeValues;
  const OptionsRow({super.key, required this.typeValues});

  @override
  State<OptionsRow> createState() => _OptionsRowState();
}

class _OptionsRowState extends State<OptionsRow> {
  late String typeValue;

  @override
  void initState() {
    super.initState();
    typeValue = widget.typeValues.first;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          dropDown(widget.typeValues, typeValue, (String? val) {
            if (val != null) {
              setState(() {
                typeValue = val;
              });
            }
          }),
        ],
      ),
    );
  }

  Widget dropDown(
    List<String> values,
    String value,
    ValueChanged<String?>? onChange,
  ) {
    return Container(
      height: 32.0,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: AppColor.secondary,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: DropdownButton<String>(
        dropdownColor: AppColor.primary,
        underline: SizedBox(height: 0),
        icon: Icon(Icons.keyboard_arrow_down_rounded),
        value: value,
        items:
            values.map((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: SizedBox(width: 80, child: Text(value)),
              );
            }).toList(),
        onChanged: onChange,
      ),
    );
  }
}
