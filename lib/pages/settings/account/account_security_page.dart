import 'package:acrilc/util.dart';
import 'package:flutter/material.dart';

class AccountSecurityPage extends StatefulWidget {
  const AccountSecurityPage({super.key});

  @override
  State<AccountSecurityPage> createState() => _AccountSecurityPageState();
}

class _AccountSecurityPageState extends State<AccountSecurityPage> {
  bool isTwoFactorEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Account & Security")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Credentials"),
            _settingItem(
              title: "Email",
              subtitle: "Manage your email",
              onTap: () => _navigateToUpdateScreen(context, "Email"),
            ),
            _settingItem(
              title: "Password",
              subtitle: "Change your password",
              onTap: () => _navigateToUpdateScreen(context, "Password"),
            ),
            const SizedBox(height: 20),
            _sectionTitle("Security"),
            _toggleSettingItem(
              title: "Two-Factor Authentication",
              subtitle: "Enhance your account security",
              value: isTwoFactorEnabled,
              onChanged: (value) {
                setState(() {
                  isTwoFactorEnabled = value;
                });
              },
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

  /// Credentials Setting Item (Navigates to a new screen)
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

  /// Security Toggle Item (For 2FA)
  Widget _toggleSettingItem({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
      trailing: Switch(value: value, onChanged: onChanged),
    );
  }

  /// Navigation to Email/Password Update Screen
  void _navigateToUpdateScreen(BuildContext context, String settingType) {
    alert(context, settingType, title: "Update");
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => UpdateCredentialPage(settingType: settingType)),
    // );
  }
}
