import 'package:acrilc/constants/colors.dart';
import 'package:acrilc/providers/theme_provider.dart';
import 'package:acrilc/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSelectionPage extends StatefulWidget {
  final String selectedTheme; // "system", "light", "dark"

  const ThemeSelectionPage({super.key, required this.selectedTheme});

  @override
  State<ThemeSelectionPage> createState() => _ThemeSelectionPageState();
}

class _ThemeSelectionPageState extends State<ThemeSelectionPage> {
  late String selectedTheme;

  @override
  void initState() {
    super.initState();
    selectedTheme = widget.selectedTheme;
  }

  void _updateTheme(String? value) {
    if (value != null) {
      setState(() {
        selectedTheme = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Theme")),
      body: Column(
        children: [
          RadioListTile<String>(
            title: const Text("System Default"),
            value: "system",
            activeColor: AppColor.primaryColor,
            groupValue: selectedTheme,
            onChanged: _updateTheme,
          ),
          RadioListTile<String>(
            title: const Text("Light Mode"),
            value: "light",
            activeColor: AppColor.primaryColor,
            groupValue: selectedTheme,
            onChanged: _updateTheme,
          ),
          RadioListTile<String>(
            title: const Text("Dark Mode"),
            value: "dark",
            activeColor: AppColor.primaryColor,
            groupValue: selectedTheme,
            onChanged: _updateTheme,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PrimaryButton(
          text: "Save",
          onPressed: () {
            Provider.of<ThemeProvider>(
              context,
              listen: false,
            ).setTheme(selectedTheme);
            Navigator.pop(context, selectedTheme);
          },
        ),
      ),
    );
  }
}
