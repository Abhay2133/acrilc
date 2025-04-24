import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HorizontalSlider extends StatelessWidget {
  final List<Map<String, dynamic>> showcase;
  // final List<Map<String, dynamic>> storyboard;
  const HorizontalSlider({super.key, required this.showcase});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const TabBar(
              isScrollable: true,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: 'Showcase'),
                Tab(text: 'Storyboard'),
                Tab(text: 'Marketplace'),
              ],
            ),
            SizedBox(
              height: 400, // You can adjust this
              child: TabBarView(
                children: [
                  _buildGridTab(context, showcase),
                  _buildGridTab(context, []),
                  _buildGridTab(context, []),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridTab(BuildContext context, List<Map<String, dynamic>> data) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1, // square ratio (can adjust height with this)
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.push(data[index]['target']);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(data[index]["imageURL"], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
