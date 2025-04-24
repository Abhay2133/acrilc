import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

class GridUI extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const GridUI({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2, // Number of columns
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.all(10),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            context.push(data[index]['target']);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              data[index]["imageURL"],
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
