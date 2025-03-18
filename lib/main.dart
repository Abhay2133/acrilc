import 'package:acrillic/constants/themes.dart';
import 'package:flutter/material.dart';
import 'router/app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: 'Acrilc',
      routerConfig: AppRouter.router,
    );
  }
}
