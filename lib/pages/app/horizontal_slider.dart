import 'package:flutter/material.dart';

class HorizontalSlider extends StatelessWidget {
  const HorizontalSlider({super.key});

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
                  _buildGridTab(context, _showcaseImages),
                  _buildGridTab(context, _storyboardImages),
                  _buildGridTab(context, _marketplaceImages),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static final List<String> _showcaseImages = [
    'assets/images/art1.png',
    'assets/images/art2.png',
    'assets/images/art3.png',
    'assets/images/art4.png',
    'assets/images/art5.png',
    'assets/images/art6.png',
  ];

  static final List<String> _storyboardImages = [
    'assets/images/story1.png',
    'assets/images/story2.png',
    'assets/images/story3.png',
  ];

  static final List<String> _marketplaceImages = [
    'assets/images/market1.png',
    'assets/images/market2.png',
    'assets/images/market3.png',
    'assets/images/market4.png',
  ];

  Widget _buildGridTab(BuildContext context, List<String> showcaseImages) {
    final List<String> randomImageUrls = List.generate(
      10,
          (index) => 'https://source.unsplash.com/random/800x${600 +
          index * 10}',
    );

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: randomImageUrls.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1, // square ratio (can adjust height with this)
        ),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              randomImageUrls[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
