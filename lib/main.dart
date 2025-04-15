import 'package:acrilc/constants/colors.dart';
import 'package:acrilc/constants/themes.dart';
import 'package:acrilc/providers/theme_provider.dart';
import 'package:acrilc/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'router/app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: "prod.env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()), // 👈 Added this
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final Brightness systemBrightness = Theme.of(context).brightness;
        if (themeProvider.themeMode == ThemeMode.system) {
          AppColor.isDarkMode = systemBrightness == Brightness.dark;
        } else {
          AppColor.isDarkMode = themeProvider.themeMode == ThemeMode.dark;
        }
        return MaterialApp.router(
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          title: 'Acrilc',
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
