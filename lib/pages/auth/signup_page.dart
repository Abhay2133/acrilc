
import 'package:acrilc/services/auth_service.dart';
import 'package:acrilc/services/log_service.dart';
import 'package:acrilc/services/user_service.dart';
import 'package:acrilc/util.dart';
import 'package:acrilc/widgets/buttons.dart';
import 'package:acrilc/widgets/inputs.dart';
import 'package:acrilc/widgets/spinner.dart';
import 'package:acrilc/widgets/starting_bg.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _uuidController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  Future<bool> _loadUserData() async {
    try {
      await UserService.getCurrentUser();
      return true;
    } catch (e) {
      if (mounted) {
        alert(context, e.toString(), title: "Failed to load user-data");
      }
      return false;
    }
  }

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        bool success = await AuthService.doSignup(
          password: _passwordController.text.trim(),
          email: _uuidController.text.trim(),
          fullName: _nameController.text.trim(),
        );
        if (success) {
          bool dataLoaded = await _loadUserData();
          if (mounted && dataLoaded) context.go("/app/home");
        }
      } catch (e) {
        LogService.error("Error: $e");
        if (mounted) {
          alert(context, e.toString(), title: "Error Message", copy: true);
        }
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Login')),
      body: StartingBG(
        mainUI: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Welcome text
                SizedBox(height: 40),
                Text(
                  "Welcome to Acrilc",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: 5),
                Text(
                  "where art find its audience",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Full Name
                      _formField("Full Name", _nameController, false),
                      SizedBox(height: 10),
                      // UUID INPUT
                      _formField("Email or Phone", _uuidController, false),
                      SizedBox(height: 10),
                      // Password Input
                      _formField("Password", _passwordController, true),

                      // Submit Button
                      SizedBox(height: 20),
                      _submitUI(),
                    ],
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ],
        ),
        showBackButton: true,
      ),
    );
  }

  Widget _submitUI() {
    return SizedBox(
      width: 280,
      child: Button(
        disabled: isLoading,
        onPressed: () {
          _signup();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text("Signup", style: Theme.of(context).textTheme.headlineMedium),
            isLoading
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Spinner(size: 16),
                )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _formField(
    String label,
    TextEditingController controller,
    bool isPassword,
  ) {
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          formLabel(label),
          InputField(
            style: Theme.of(context).textTheme.bodyLarge,
            controller: controller,
            hintText: '',
            isPassword: isPassword,
          ),
        ],
      ),
    );
  }

  Widget formLabel(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}
