import 'dart:math';
import 'package:acrillic/widgets/sidepanel.dart';
import 'package:acrillic/pages/app/home_screen.dart';
import 'package:flutter/material.dart';

class AppPage extends StatefulWidget {
  final int selectedIndex;
  const AppPage(this.selectedIndex, {super.key});

  @override
  AppPageState createState() => AppPageState();
}

class AppPageState extends State<AppPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [wip(), wip(), wip(), wip(), wip()];

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
      appBar: AppBar(
        title: Center(child: const Text('Acrilc')),
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
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Discover'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'New'),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
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
