import 'package:flutter/material.dart';

class MoodboardScreen extends StatefulWidget {
  final String userId;

  const MoodboardScreen({super.key, required this.userId});

  @override
  State<MoodboardScreen> createState() => _MoodboardScreenState();
}

class _MoodboardScreenState extends State<MoodboardScreen> {
  final PageController _pageController = PageController();
  final List<String> tabs = ["Artists to Follow", "New Arrivals", "Trending Now", "For You"];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).textTheme.labelLarge?.color ?? Colors.white;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Mood Boards"),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          CircleAvatar(
            // backgroundColor: Colors.white,
            child: Icon(Icons.music_note),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: tabs.length,
              itemBuilder: (context, index) {
                final isSelected = _currentIndex == index;
                return GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: isSelected
                        ? BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: themeColor,
                        ),
                      ),
                    )
                        : null,
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        color: themeColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (val) {
                setState(() {
                  _currentIndex = val;
                });
              },
              children: tabs
                  .map((tab) => MoodTab(userId: widget.userId, tabName: tab))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class MoodTab extends StatelessWidget {
  final String userId;
  final String tabName;

  const MoodTab({super.key, required this.userId, required this.tabName});

  final List<Map<String, dynamic>> artists = const [
    {
      "name": "Sambit Ghosh",
      "status": "Supporting",
      "images": [
        {"title": "Kalamkari Art Print", "url": "https://source.unsplash.com/random/200x200?art"},
        {"title": "Ceramic Vase", "url": "https://source.unsplash.com/random/201x201?ceramic"},
        {"title": "Digital Art", "url": "https://source.unsplash.com/random/202x202?digital"},
        {"title": "Ceramic Vase", "url": "https://source.unsplash.com/random/203x203?vase"},
      ],
    },
    {
      "name": "Edward Snowden",
      "status": "Support",
      "images": [
        {"title": "Painting", "url": "https://source.unsplash.com/random/204x204?painting"},
        {"title": "Terracotta Horse", "url": "https://source.unsplash.com/random/205x205?terracotta"},
        {"title": "Kathakali Painting", "url": "https://source.unsplash.com/random/206x206?kathakali"},
        {"title": "Craft", "url": "https://source.unsplash.com/random/207x207?craft"},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: artists.length,
      itemBuilder: (context, artistIndex) {
        final artist = artists[artistIndex];
        final images = artist["images"] as List<dynamic>;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Info
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage:
                  NetworkImage('https://source.unsplash.com/random/100x100?face'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      artist["name"],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      artist["status"],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Image Grid
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final item = images[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          item["url"],
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item["title"],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}
