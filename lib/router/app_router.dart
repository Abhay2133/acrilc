import 'package:acrillic/pages/settings/account_security/account_security_page.dart';
import 'package:acrillic/pages/settings/profile_settings_page.dart'
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
      _buildRoute('/', const HomePage()),
      _buildRoute('/login', const LoginPage()),
      _buildRoute('/signup', const SignupPage()),

      _buildRoute('/app/home', AppPage(0)),
      _buildRoute('/app/discover', AppPage(1)),
      _buildRoute('/app/post', AppPage(2)),
      _buildRoute('/app/index', AppPage(3)),
      _buildRoute('/app/profile', AppPage(4)),

      _buildRoute('/app/settings', const SettingsPage()),
      _buildRoute('/app/settings/profile', const ProfileSettingsPage()),
      _buildRoute("/app/settings/account_security", AccountSecurityPage()),
    ],
    redirect: (context, state) async {
      final loggedIn = await isLoggedIn();
      if (!loggedIn) {
        return "/";
      }
      return state.fullPath;
    },
    errorBuilder: (context, state) => const NotFoundPage(),
  );

  static GoRoute _buildRoute(String path, Widget page) {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) => buildPageWithTransition(state, page),
    );
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
