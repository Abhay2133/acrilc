import 'package:acrilc/models/user.dart';
import 'package:acrilc/services/auth_service.dart';
import 'package:acrilc/services/user_service.dart';
import 'package:acrilc/util.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class SidePanel extends StatefulWidget {
  const SidePanel({super.key});

  @override
  State<SidePanel> createState() => _SidePanelState();
}

class _SidePanelState extends State<SidePanel> {
  String? _username;
  @override
  void initState() {
    super.initState();

    _loadUserData();
  }

  void _loadUserData() async {
    UserData? userData = await UserService.getCurrentUser();
    if (userData == null && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to load user data")));
    }
    setState(() {
      _username = userData?.fullName;
    });
  }

  Future<void> _logout(BuildContext context) async {
    bool confirmed = await confirm(
      context: context,
      title: "Confirm Logout",
      body: "You will not lose any data.",
    );
    if(!confirmed) return;
    await AuthService.doLogout();
    if (context.mounted) context.go("/");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [SizedBox(height: 30), backButton(), user(), list()],
      ),
    );
  }

  Widget listItem(String title, VoidCallback onTap) {
    return ListTile(title: Text(title), onTap: onTap);
  }

  Widget list() {
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Flex(
            direction: Axis.vertical,
            children: [
              listItem("Settings", () {
                Navigator.pop(context);
                context.push("/settings");
              }),
              listItem("Moodboard", () {
                Navigator.pop(context);
                context.push("/moodboard/amit");
              }),
              listItem("Analytics", () {
                alert(context, "Stay tuned", title: "Coming soon");
              }),
              listItem("Logout", () {
                _logout(context);
              }),
            ],
          ),
        );
      },
    );
  }

  Widget user() {
    return Builder(
      builder: (context) {
        return InkWell(
          onTap: () {
            context.pop();
            context.push("/app/profile");
          },
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text(
                  _username ?? "loading...",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget backButton() {
    return Builder(
      builder: (context) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
          ],
        );
      },
    );
  }
}
