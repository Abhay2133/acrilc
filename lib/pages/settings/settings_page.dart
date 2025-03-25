import 'package:acrillic/util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            context.pop();
          },
        ),
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
                  context.push('/app/settings/profile');
                },
              ),
              // Divider(),
              settingItem(
                Icon(Icons.email, color: Colors.green),
                "Account Settings",
                () {
                  context.push('/app/settings/account_security');
                },
              ),
              // Divider(),
              settingItem(
                Icon(Icons.settings, color: Colors.orange),
                "Preferences",
                () {
                  alert(context, "Preferences tapped");
                },
              ),
              // Divider(),
              settingItem(
                Icon(Icons.palette, color: Colors.purple),
                "Appearance",
                () {
                  alert(context, "Appearance tapped");
                },
              ),
              // Divider(),
              settingItem(
                Icon(Icons.warning, color: Colors.red),
                "Danger Zone",
                () {
                  alert(context, "Danger Zone tapped");
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
