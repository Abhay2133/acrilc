import 'package:acrilc/pages/app/chat_screen.dart';
import 'package:acrilc/pages/app/discover_screen.dart';
import 'package:acrilc/pages/app/home_screen.dart';
import 'package:acrilc/pages/app/profile_screen.dart';
import 'package:acrilc/pages/chat/user_chat.dart';
import 'package:acrilc/pages/chat/users_list.dart';
import 'package:acrilc/pages/discover/theme_screen.dart';
import 'package:acrilc/pages/moodboard/moodboard_screen.dart';
import 'package:acrilc/pages/portfolio/user_portfolio.dart';
import 'package:acrilc/pages/post/create_post_screen.dart';
import 'package:acrilc/pages/post/show_post_screen.dart';
import 'package:acrilc/pages/settings/account/account_security_page.dart';
import 'package:acrilc/pages/settings/appearance/appearance_settings_page.dart';
import 'package:acrilc/pages/settings/preference_settings_page.dart';
import 'package:acrilc/pages/settings/profile_settings/forte_page.dart';
import 'package:acrilc/pages/settings/profile_settings/profile_settings_page.dart'
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

enum TransitionType {
  slideWest,
  slideEast,
  slideSouth,
  slideNorth,
  fade,
  scale,
  none,
}

class AppRouter {
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("jwt_token") != null;
  }

  static final GoRouter router = GoRouter(
    initialLocation: '/app/home',
    routes: [
      _buildARoute('/', const HomePage()),
      _buildARoute(
        '/login',
        const LoginPage(),
        transition: TransitionType.none,
      ),
      _buildARoute(
        '/signup',
        const SignupPage(),
        transition: TransitionType.none,
      ),

      // App Routes
      ShellRoute(
        builder: (context, state, child) {
          return AppPage(child: child);
        },
        routes: [
          _buildRoute('/app/home', HomeScreen()),
          _buildRoute("/app/discover", DiscoverScreen()),
          // _buildRoute("/app/post", WIP()),
          _buildRoute("/app/chat", ChatScreen()),
          _buildRoute("/app/profile", ProfileScreen()),
        ],
      ),

      // discover -> theme
      _buildARoute(
        '/discover/:theme',
        null,
        builder: (context, state) {
          final String theme = state.pathParameters["theme"] ?? "";
          return ForteScreen(forte: theme);
        },
      ),

      // Settings Routes
      _buildARoute('/settings', const SettingsPage()),
      _buildARoute('/settings/profile', const ProfileSettingsPage()),
      _buildARoute("/settings/profile/forte", FortePage()),
      _buildARoute("/settings/account_security", AccountSecurityPage()),
      _buildARoute("/settings/preferences", PreferencesSettingsPage()),
      _buildARoute("/settings/appearance", AppearanceSettingsPage()),

      // Post Routes
      _buildARoute(
        "/post/create",
        CreatePostScreen(),
        transition: TransitionType.slideNorth,
      ),
      _buildARoute(
        "/post/:postId",
        null,
        builder: (context, state) {
          final String postId = state.pathParameters["postId"] ?? "";
          return ShowPostScreen(postId: postId);
        },
      ),

      // Chat routes
      _buildARoute("/chat/new", UsersList()),
      _buildARoute(
        "/chat/:userId",
        null,
        builder: (context, state) {
          final String userId = state.pathParameters["userId"] ?? "";
          return UserChat(userId: userId);
        },
      ),

      // Portfolio route
      _buildARoute(
        "/portfolio/:userId",
        null,
        builder: (context, state) {
          final String userId = state.pathParameters["userId"] ?? "";
          return UserPortfolio(userId: userId);
        },
      ),

      // moodboard route
      _buildARoute(
        "/moodboard/:userId",
        null,
        builder: (context, state) {
          final String userId = state.pathParameters["userId"] ?? "";
          return MoodboardScreen(userId: userId);
        },
      ),
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

  static GoRoute _buildRoute(String path, Widget page) {
    return GoRoute(path: path, builder: (context, state) => page);
  }

  static GoRoute _buildARoute(
    String path,
    Widget? page, {
    TransitionType transition = TransitionType.slideWest,
    Widget Function(BuildContext, GoRouterState)? builder,
  }) {
    if (builder != null) {
      return GoRoute(
        path: path,
        pageBuilder: (context, state) {
          Widget widget = builder(context, state);
          return buildPageWithTransition(state, widget, transition);
        },
      );
    } else if (page == null) {
      throw Exception("either 'page' or 'builder' should be pass in args.");
    }
    return GoRoute(
      path: path,
      pageBuilder:
          (context, state) => buildPageWithTransition(state, page, transition),
    );
  }

  static CustomTransitionPage buildPageWithTransition(
    GoRouterState state,
    Widget child, [
    TransitionType transitionType = TransitionType.slideWest,
  ]) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (transitionType) {
          case TransitionType.fade:
            return FadeTransition(opacity: animation, child: child);
          case TransitionType.scale:
            return ScaleTransition(scale: animation, child: child);
          case TransitionType.slideWest:
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            final tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));
            final offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          case TransitionType.slideNorth:
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            final tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));
            final offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          case TransitionType.none:
            return child;
          default:
            throw UnimplementedError(
              "Unimplemented transition : $transitionType",
            );
        }
      },
    );
  }
}
