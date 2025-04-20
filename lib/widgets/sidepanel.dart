import 'package:acrilc/util.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SidePanel extends StatelessWidget {
  const SidePanel({super.key});

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("jwt_token");
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
            context.push("/app/profile");
          },
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text(
                  "Username",
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
