import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:acrilc/models/post.dart';

class ShowPostScreen extends StatelessWidget {
  final String postId;
  final String backURL;

  const ShowPostScreen({
    super.key,
    required this.postId,
    this.backURL = "/app/home",
  });
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(height: 300.0),
                  items: [1, 2, 3].map((i) {
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
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Secure It", style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text("Save to Moodboard"),
                        Text("Move to Storyboard"),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                "Under The Moonlight",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                "Acrylic on canvas",
                style: TextStyle(color: Colors.white70),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: const Text(
                "30 x 40 in",
                style: TextStyle(color: Colors.white70),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text(
                "Story Behind the Art",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Inspired by the artist’s childhood memory of playing under the moonlight.",
                style: TextStyle(color: Colors.white70),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text("Applauds", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text("Comment", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text("Appreciate", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                child: const Text(
                  "Move to Marketplace",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.black,
      //   selectedItemColor: Colors.black,
      //   unselectedItemColor: Colors.black,
      //   currentIndex: 2, // Set to "Post"
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      //     BottomNavigationBarItem(icon: Icon(Icons.groups), label: "Community"),
      //     BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: "Post"),
      //     BottomNavigationBarItem(icon: Icon(Icons.inbox), label: "Inbox"),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
      //   ],
      //   onTap: (index) {
      //     // Handle bottom navigation tap
      //   },
      // ),
    );
  }
}