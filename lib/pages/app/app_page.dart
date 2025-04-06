import 'dart:math';
import 'package:acrillic/pages/app/profile_screen.dart';
import 'package:acrillic/widgets/sidepanel.dart';
import 'package:acrillic/pages/app/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // show GoRouterHelper, GoRouterState;

enum Page { home, discover, post, chat, profile }

class AppPage1 extends StatelessWidget {
  final Widget child;

  const AppPage1({super.key, required this.child});

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

      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getSelectedIndex(context),
        onTap: (index) {
          if (index == Page.home.index) return context.go("/app/home");
          if (index == Page.discover.index) return context.go("/app/discover");
          if (index == Page.post.index) return context.go("/app/post");
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

class AppPage extends StatefulWidget {
  final int selectedIndex;
  final Widget child;
  const AppPage(this.selectedIndex, {super.key, required this.child});

  @override
  AppPageState createState() => AppPageState();
}

class AppPageState extends State<AppPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    wip(),
    wip(),
    wip(),
    ProfileScreen(),
  ];

  static wip() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      // color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,

        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/wip.png',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          Text("Work in Progress"),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Discover'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'Post'),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
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
    );
  }
}
