import 'package:acrilc/constants/colors.dart';
import 'package:acrilc/services/log_service.dart';
import 'package:acrilc/widgets/input.dart';
import 'package:acrilc/widgets/post_container.dart';
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
          // searchBar(),
          Input(
            searchController: _searchController,
            onSearchChange: _onSearchChange,
          ),
          SizedBox(height: 10),
          // OptionsRow(typeValues: typeValues),
          SizedBox(height: 10),
          PostContainer(),
        ],
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
