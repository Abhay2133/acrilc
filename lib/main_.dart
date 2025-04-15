import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MasonryGridExample());
  }
}

class MasonryGridExample extends StatelessWidget {
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.cyan,
    Colors.teal,
    Colors.amber,
    Colors.brown,
    Colors.pink,
  ];

  MasonryGridExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Masonry Grid')),
      body: MasonryGridView.count(
        crossAxisCount: 2, // Number of columns
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.all(10),
        itemCount: 20,
        itemBuilder: (context, index) {
          return Container(
            height: 100.0 + (index % 5) * 20, // Varying heights
            color: colors[index % colors.length],
            child: Center(
              child: Text(
                'Item $index',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
