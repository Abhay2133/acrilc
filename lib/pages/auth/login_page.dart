
import 'package:acrilc/constants/colors.dart';
import 'package:acrilc/services/auth_service.dart';
import 'package:acrilc/services/log_service.dart';
import 'package:acrilc/services/user_service.dart';
import 'package:acrilc/widgets/buttons.dart';
import 'package:acrilc/widgets/inputs.dart';
import 'package:acrilc/widgets/starting_bg.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _uuidController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    LogService.debug("appcolor");
    print(AppColor);
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      String email = _uuidController.text.trim();
      String password = _passwordController.text.trim();

      bool isLoggedIn = await AuthService.doLogin(email, password);
      if (isLoggedIn) {
        await UserService.getCurrentUser();
        if (mounted) context.go("/app/home");
      } else {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Login Failed")));
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StartingBG(
        showBackButton: true,
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
                  style: Theme.of(context).textTheme.headlineMedium
                ),
                SizedBox(height: 5),
                Text(
                  "where art find its audience",
                  style: Theme.of(context).textTheme.bodyLarge
                ),
                SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // UUID INPUT
                      formField("Email or Phone", _uuidController, false),
                      SizedBox(height: 10),
                      // Password Input
                      formField("Password", _passwordController, true),

                      // Submit Button
                      SizedBox(height: 20),
                      SizedBox(
                        width: 280,
                        child: Button(
                          disabled: isLoading,
                          onPressed: () {
                            _login();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "Login",
                                style: Theme.of(context).textTheme.headlineMedium
                              ),
                              isLoading
                                  ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: loader(size: 16),
                                  )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget loader({double size = 20}) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          AppColor.primaryText,
        ), // Custom color
        strokeWidth: 2.0, // Thickness of the spinner
      ),
    );
  }

  Widget formField(
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
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
      child: Text(text, style: Theme.of(context).textTheme.headlineMedium),
    );
  }
}
