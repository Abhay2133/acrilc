import 'package:acrilc/util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              settingItem(
                Icon(Icons.person, color: Colors.blue),
                "Profile Settings",
                () {
                  // Navigate to Profile Settings screen or execute logic.
                  context.push('/settings/profile');
                },
              ),
              // Divider(),
              settingItem(
                Icon(Icons.email, color: Colors.green),
                "Account Settings",
                () {
                  context.push('/settings/account_security');
                },
              ),
              // Divider(),
              settingItem(
                Icon(Icons.settings, color: Colors.orange),
                "Preferences",
                () {
                  context.push("/settings/preferences");
                },
              ),
              // Divider(),
              settingItem(
                Icon(Icons.palette, color: Colors.purple),
                "Appearance",
                () {
                  context.push("/settings/appearance");
                },
              ),
              // Divider(),
              settingItem(
                Icon(Icons.warning, color: Colors.red),
                "Danger Zone",
                () {
                  alert(context, "Coming Soon", title: "Stay Tuned");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget settingItem(Icon icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          children: [
            icon,
            SizedBox(width: 15),
            Expanded(child: Text(title, style: TextStyle(fontSize: 16))),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
