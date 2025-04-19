import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class ShowPostScreen extends StatefulWidget {
  final String postId;
  final String backURL;

  const ShowPostScreen({
    super.key,
    required this.postId,
    this.backURL = "/app/home",
  });

  @override
  State<ShowPostScreen> createState() => _ShowPostScreenState();
}

class _ShowPostScreenState extends State<ShowPostScreen> {
  void _onMenuSelected(String value) {
    // You can handle your logic here
    print("Selected: $value");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        // backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: _onMenuSelected,
            icon: Icon(Icons.more_vert),
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem(value: 'secure_it', child: Text('Secure it')),
                  PopupMenuItem(value: 'moodboard', child: Text('Save to Moodboard')),
                  PopupMenuItem(value: 'storyboard', child: Text('Move to Storyboard')),
                ],
          ),
          SizedBox(width: 8,)
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(height: 300.0),
              items:
                  [1, 2, 3].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[800],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              "assets/images/wip.png",
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
            ),

            // Positioned(
            //   top: 16,
            //   right: 16,
            //   child: Container(
            //     padding: const EdgeInsets.all(12),
            //     decoration: BoxDecoration(
            //       color: Colors.white.withOpacity(0.9),
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: const [
            //         Text(
            //           "Secure It",
            //           style: TextStyle(fontWeight: FontWeight.bold),
            //         ),
            //         SizedBox(height: 8),
            //         Text("Save to Moodboard"),
            //         Text("Move to Storyboard"),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Under The Moonlight",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Acrylic on canvas",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 4,
              ),
              child: Text(
                "30 x 40 in",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text(
                "Story Behind the Art",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Inspired by the artist’s childhood memory of playing under the moonlight.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Applauds", style: Theme.of(context).textTheme.bodyMedium),
                Text("Comment", style: Theme.of(context).textTheme.bodyMedium),
                Text(
                  "Appreciate",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Navigate to marketplace
                },
                child: Text(
                  "Move to Marketplace",
                  style: Theme.of(context).textTheme.bodyMedium?.apply(
                    color: Colors.white,
                    fontWeightDelta: 3,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
