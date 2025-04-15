import 'package:acrilc/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_selection_page.dart';
import 'font_size_selection_page.dart';

class AppearanceSettingsPage extends StatefulWidget {
  const AppearanceSettingsPage({super.key});

  @override
  State<AppearanceSettingsPage> createState() => _AppearanceSettingsPageState();
}

class _AppearanceSettingsPageState extends State<AppearanceSettingsPage> {
  String selectedTheme = "system"; // Default
  double fontSize = 16.0; // Default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Appearance Settings")),
      body: ListView(
        children: [
          _sectionTitle("Appearance"),

          /// **Theme Option**
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListTile(
              title: const Text("Theme"),
              subtitle: Text(selectedTheme.toUpperCase()),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () async {
                ThemeProvider themeProvider = Provider.of<ThemeProvider>(
                  context,
                  listen: false,
                );
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => ThemeSelectionPage(
                          selectedTheme: themeProvider.savedTheme,
                        ),
                  ),
                );
                if (result != null) {
                  setState(() {
                    selectedTheme = result;
                  });
                }
              },
            ),
          ),

          /// **Font Size Option**
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListTile(
              title: const Text("Font Size"),
              subtitle: Text("Current: ${fontSize.round()}"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => FontSizeSelectionPage(currentFontSize: fontSize),
                  ),
                );
                if (result != null) {
                  setState(() {
                    fontSize = result;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
