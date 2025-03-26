import 'package:acrillic/pages/settings/account/account_security_page.dart';
import 'package:acrillic/pages/settings/appearance/appearance_settings_page.dart';
import 'package:acrillic/pages/settings/preference_settings_page.dart';
import 'package:acrillic/pages/settings/profile_settings/forte_page.dart';
import 'package:acrillic/pages/settings/profile_settings/profile_settings_page.dart'
    show ProfileSettingsPage;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/home/home_page.dart';
import '../pages/auth/login_page.dart';
import '../pages/auth/signup_page.dart';
import '../pages/app/app_page.dart';
import '../pages/error/not_found_page.dart';
import '../pages/settings/settings_page.dart';

class AppRouter {
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("jwt_token") != null;
  }

  static final GoRouter router = GoRouter(
    initialLocation: '/app/home',
    routes: [
      _buildARoute('/', const HomePage()),
      _buildARoute('/login', const LoginPage()),
      _buildARoute('/signup', const SignupPage()),

      _buildARoute('/app/home', AppPage(0)),
      _buildARoute('/app/discover', AppPage(1)),
      _buildARoute('/app/post', AppPage(2)),
      _buildARoute('/app/index', AppPage(3)),
      _buildARoute('/app/profile', AppPage(4)),

      _buildARoute('/app/settings', const SettingsPage()),
      _buildARoute('/app/settings/profile', const ProfileSettingsPage()),
      _buildARoute("/app/settings/profile/forte", FortePage()),
      _buildARoute("/app/settings/account_security", AccountSecurityPage()),
      _buildARoute("/app/settings/preferences", PreferencesSettingsPage()),
      _buildARoute("/app/settings/appearance", AppearanceSettingsPage()),
    ],
    redirect: (context, state) async {
      if (state.fullPath == "/" ||
          state.fullPath == "/login" ||
          state.fullPath == "/signup") {
        return null;
      }
      final loggedIn = await isLoggedIn();
      if (!loggedIn) {
        return "/";
      }
      return null;
    },
    errorBuilder: (context, state) => const NotFoundPage(),
  );

  static GoRoute _buildARoute(String path, Widget page) {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) => buildPageWithTransition(state, page),
    );
  }

  static GoRoute _buildRoute(String path, Widget page) {
    return GoRoute(path: path, builder: (context, state) => page);
  }

  static CustomTransitionPage buildPageWithTransition(
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
