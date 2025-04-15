import 'package:acrilc/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Settings")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Personal Information"),
            _settingItem(
              title: "Name",
              subtitle: "Your full name",
              onTap: () => _showEditBottomSheet(context, "Name"),
            ),
            _settingItem(
              title: "Username",
              subtitle: "Your unique username",
              onTap: () => _showEditBottomSheet(context, "Username"),
            ),
            _settingItem(
              title: "Bio",
              subtitle: "Tell something about yourself",
              onTap:
                  () => _showEditBottomSheet(
                    context,
                    "Bio",
                    isMultiLine: true,
                    maxLength: 150,
                  ),
            ),
            _settingItem(
              title: "Story",
              subtitle: "Write your story",
              onTap:
                  () => _showEditBottomSheet(
                    context,
                    "Story",
                    isMultiLine: true,
                    maxLength: 300,
                  ),
            ),
            _settingItem(
              title: "Forte",
              subtitle: "Your art preferences",
              onTap:
                  () => context.push("/settings/profile/forte"),
            ),
            const SizedBox(height: 20),
            _sectionTitle("Social Links"),
            _socialLinkItem("Facebook", Icons.facebook, Colors.blue),
            _socialLinkItem("X", Icons.alternate_email, Colors.black),
            _socialLinkItem("Instagram", Icons.camera_alt, Colors.purple),
          ],
        ),
      ),
    );
  }

  /// Section Title
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// Personal Info Setting Item
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

  /// Social Link Item with Link Button
  Widget _socialLinkItem(String platform, IconData icon, Color color) {
    return Builder(
      builder: (context) {
        return ListTile(
          leading: Icon(icon, color: color),
          title: Text(
            platform,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          trailing: ElevatedButton(
            onPressed: () {
              // Handle linking/unlinking logic
            },
            child: Text("Link", style: Theme.of(context).textTheme.bodyMedium),
          ),
        );
      },
    );
  }

  /// Bottom Sheet for Editing Personal Info
  void _showEditBottomSheet(
    BuildContext context,
    String title, {
    bool isMultiLine = false,
    int maxLength = 50,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Edit $title",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  maxLines: isMultiLine ? 4 : 1,
                  maxLength: maxLength,
                  decoration: InputDecoration(
                    hintText: "Enter your $title",
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: PrimaryButton(
                    text: "Save",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
