import 'package:flutter/material.dart';

class PreferencesSettingsPage extends StatefulWidget {
  const PreferencesSettingsPage({super.key});

  @override
  State<PreferencesSettingsPage> createState() =>
      _PreferencesSettingsPageState();
}

class _PreferencesSettingsPageState extends State<PreferencesSettingsPage> {
  String selectedVisibility = "Public";
  String selectedRegion = "United States";
  String selectedLanguage = "English";
  List<String> selectedPreferences = ["Default"];

  final List<String> visibilityOptions = ["Public", "Private", "Friends Only"];
  final List<String> regionOptions = [
    "United States",
    "India",
    "United Kingdom",
    "Germany",
    "France",
  ];
  final List<String> languageOptions = [
    "English",
    "Spanish",
    "French",
    "German",
    "Hindi",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Preferences & Localization")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("General Preferences"),
            _dropdownSettingItem(
              title: "Visibility",
              value: selectedVisibility,
              options: visibilityOptions,
              onChanged: (value) => setState(() => selectedVisibility = value),
            ),
            const SizedBox(height: 20),
            _sectionTitle("Localization"),
            _dropdownSettingItem(
              title: "Region",
              value: selectedRegion,
              options: regionOptions,
              onChanged: (value) => setState(() => selectedRegion = value),
            ),
            _dropdownSettingItem(
              title: "Language",
              value: selectedLanguage,
              options: languageOptions,
              onChanged: (value) => setState(() => selectedLanguage = value),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Title Widget
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// Dropdown Setting Item
  Widget _dropdownSettingItem({
    required String title,
    required String value,
    required List<String> options,
    required ValueChanged<String> onChanged,
  }) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: DropdownButton<String>(
        value: value,
        items:
            options.map((option) {
              return DropdownMenuItem(value: option, child: Text(option));
            }).toList(),
        onChanged: (newValue) {
          if (newValue != null) onChanged(newValue);
        },
      ),
    );
  }

  /// Preference Setting Item (Opens new screen)
  Widget _settingItem({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
