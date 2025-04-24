import 'dart:math';
import 'package:acrilc/constants/sample.dart';
import 'package:acrilc/pages/post/create_post_screen.dart';
import 'package:acrilc/services/log_service.dart';
import 'package:acrilc/services/websocket_service.dart';
import 'package:acrilc/widgets/sidepanel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// show GoRouterHelper, GoRouterState;

enum Page { home, discover, post, chat, profile }

class AppPage extends StatefulWidget {
  final Widget child;

  const AppPage({super.key, required this.child});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  void initState() {
    super.initState();

    final socket = WebSocketService();
    socket.connect();
    socket.onAny = _onMessage;

    Future.delayed(Duration(seconds: 1), () {
      // _testEditPost();
    });
  }

  void _testEditPost() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreatePostScreen(postData: samplePost),
      ),
    );

    LogService.debug(result);
  }

  dynamic _onMessage(String? event, dynamic data) {
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("$event")));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            'acrilc',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        leading: SizedBox(),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(pi),
                  child: const Icon(Icons.sort),
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                  // Add drawer action or menu logic
                },
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Removes rounded corners
        ),
        child: Container(
          width:
              double.infinity, //.of(context).size.width, // Full-width drawer
          color: Colors.white, // Set background color
          child: SidePanel(),
        ),
      ),

      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getSelectedIndex(context),
        onTap: (index) {
          if (index == Page.home.index) return context.go("/app/home");
          if (index == Page.discover.index) return context.go("/app/discover");
          if (index == Page.post.index) {
            context.push("/post/create");
            return;
          }
          if (index == Page.chat.index) return context.go("/app/chat");
          if (index == Page.profile.index) return context.go("/app/profile");
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Discover'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'Post'),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location == "/app/discover") return Page.discover.index;
    if (location == "/app/post") return Page.post.index;
    if (location == "/app/chat") return Page.chat.index;
    if (location == "/app/profile") return Page.profile.index;
    return Page.home.index;
  }
}
