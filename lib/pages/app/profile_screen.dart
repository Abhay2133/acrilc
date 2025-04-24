import 'package:acrilc/constants/colors.dart';
import 'package:acrilc/services/user_service.dart';
import 'package:acrilc/util.dart';
import 'package:acrilc/widgets/carousel.dart';
import 'package:acrilc/widgets/circular_tag.dart';
import 'package:acrilc/widgets/img.dart';
import 'package:acrilc/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:acrilc/widgets/horizontal_slider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;
  bool _isLoading = false;
  bool _isFailed = false;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  void _fetchUser() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Map<String, dynamic>? data = await UserService.getUser("me");
      if (data == null) {
        setState(() {
          _isFailed = true;
        });
      } else {
        setState(() {
          _isFailed = false;
        });
        userData = data;
      }
    } catch (e) {
      setState(() {
        _isFailed = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchUser() async {}

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: Spinner(size: 60));
    } else if (!_isFailed && userData != null)
      // ignore: curly_braces_in_flow_control_structures
      return ProfileWidget(userData: userData!);
    else
      // ignore: curly_braces_in_flow_control_structures
      return Text("Failed to load");
  }
}

class Review {
  final String reviewerName;
  final String reviewDate;
  final int stars;
  final String text;

  Review({
    required this.reviewerName,
    required this.reviewDate,
    required this.stars,
    required this.text,
  });
}

class ProfileWidget extends StatelessWidget {
  final Map<String, dynamic> userData;
  const ProfileWidget({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    List<Review> reviews = [
      Review(
        reviewerName: "Alice Johnson",
        reviewDate: "March 20, 2025",
        stars: 5,
        text:
            "Amazing service! Highly recommended for anyone looking for quality work.",
      ),
      Review(
        reviewerName: "David Smith",
        reviewDate: "March 18, 2025",
        stars: 4,
        text:
            "Great experience overall. A few minor improvements would make it perfect.",
      ),
      Review(
        reviewerName: "Emily Carter",
        reviewDate: "March 15, 2025",
        stars: 5,
        text:
            "Absolutely fantastic! The team went above and beyond my expectations.",
      ),
      Review(
        reviewerName: "Michael Brown",
        reviewDate: "March 10, 2025",
        stars: 3,
        text: "Decent service, but there were some delays in response time.",
      ),
      Review(
        reviewerName: "Sophia Wilson",
        reviewDate: "March 5, 2025",
        stars: 5,
        text:
            "Excellent support and a well-designed platform. Very happy with it!",
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileSection(
            profilePicture: userData['profilePicture'] ?? "",
            name: userData['fullName'] ?? "",
            bio: userData['bio'] ?? "",
          ),
          ProfileCards(
            totalFollowers: userData['totalFollowers'] ?? 0,
            totalFollowing: userData['totalFollwing'] ?? 0,
            posts: userData['posts'] ?? 0,
          ),
          ActionButtons(),
          Forte(fortes: userData['preferences'],),
          Story(),
          HorizontalSlider(),
          // portfolio button
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(200), // Set border radius
                ),
              ),
              onPressed: () {
                // alert(context, "Hello");
                context.push("/portfolio/me");
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  "Portfolio",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  final String profilePicture;
  final String name;
  final String bio;

  const ProfileSection({
    super.key,
    required this.profilePicture,
    required this.name,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Banner + Name
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/profile-banner.png',
                  ), // Change to your banner image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style:
                        Theme.of(context).textTheme.headlineLarge, // Uses theme
                  ),
                  SizedBox(height: 4),
                  Text(
                    bio,
                    style:
                        Theme.of(context).textTheme.titleMedium, // Uses theme
                  ),
                  SizedBox(height: 6),
                  Wrap(
                    spacing: 6.0,
                    runSpacing: 4.0,
                    children: [
                      CircularTag(label: "Room Decor"),
                      CircularTag(label: "Consultation"),
                      CircularTag(label: "Art Therapy"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        // Profile Image
        Positioned(
          right: 20,
          top: 80,
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white54, width: 3),
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/profile-pic.png',
                ), // Change to your banner image
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(500),
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileCards extends StatelessWidget {
  final int totalFollowers;
  final int totalFollowing;
  final int posts;

  const ProfileCards({
    super.key,
    required this.totalFollowers,
    required this.totalFollowing,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    double gap = 8;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              card("Supporters", "$totalFollowers", context),
              SizedBox(width: gap),
              card("Supporting", "$totalFollowing", context),
              SizedBox(width: gap),
              card("Posts", "$posts", context),
            ],
          ),
          SizedBox(height: gap),
          Row(
            children: [
              card("Patrons", "0", context),
              SizedBox(width: gap),
              card("Community", "0", context),
            ],
          ),
        ],
      ),
    );
  }

  Widget card(String title, String value, BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        // height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, style: Theme.of(context).textTheme.headlineLarge),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE34A1C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(200), // Set border radius
                ),
              ),
              onPressed: () {
                alert(context, "Hello");
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  "Support",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE34A1C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(200), // Set border radius
                ),
              ),
              onPressed: () {
                alert(context, "Hello");
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  "Message",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Forte extends StatelessWidget {
  final List<dynamic> fortes;
  const Forte({super.key, required this.fortes});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Forte", style: Theme.of(context).textTheme.headlineLarge),
          SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: 
              fortes.map((forte){
                return card(context, forte, "");
              }).toList()
            // [
            //   card(context, "Painting", "Abstract Painting"),
            //   card(context, "Sculpture", "Sculptures"),
            // ],
          ),
        ],
      ),
    );
  }

  Widget card(BuildContext context, String title, String subtitle) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Img(
            lightImage: "assets/images/brush-black.svg",
            darkImage: "assets/images/brush.svg",
            height: 30,
          ),
          SizedBox(height: 10),
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          SizedBox(height: 5),
          Text(subtitle, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

class Story extends StatelessWidget {
  final List<Map<String, String>> cards;
  const Story({
    super.key,
    this.cards = const [
      {"src": "", "title": "Card title 1", "detail": "Card details 1"},
      {"src": "", "title": "Card title 2", "detail": "Card details 2"},
      {"src": "", "title": "Card title 3", "detail": "Card details 3"},
      {"src": "", "title": "Card title 4", "detail": "Card details 4"},
    ],
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWith = (constraints.maxWidth * 0.8).clamp(200, 400);
        List<Widget> storyCards =
            cards.map((item) {
              return card(item, cardWith);
            }).toList();
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Story of Artist",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 10),
              Text(
                "My work is an exploration of the human experience through abstraction. I use a variety of materials and techniques to create a rich surface that reflects the complexity of life.",
              ),
              SizedBox(height: 10),
              Carousel(items: storyCards),
            ],
          ),
        );
      },
    );
  }

  Widget card(Map<String, String> card, double cardWith) {
    return Builder(
      builder: (context) {
        return Container(
          height: 270,
          width: cardWith,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage('assets/images/profile-banner.png'),
                    // Change to your banner image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  card['title'].toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(card['detail'].toString()),
              ),
            ],
          ),
        );
      },
    );
  }
}

class GridGallery extends StatelessWidget {
  const GridGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(children: [header()]),
    );
  }

  Widget header() {
    return Builder(
      builder: (context) {
        TextStyle activeTabStyle = Theme.of(context).textTheme.headlineMedium!;
        TextStyle tabStyle = TextStyle(
          fontSize: activeTabStyle.fontSize,
          color: activeTabStyle.color,
        );
        return Flex(
          direction: Axis.horizontal,
          spacing: 12,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 2, color: activeTabStyle.color!),
                ),
              ),
              child: Text("Showcase", style: activeTabStyle),
            ),
            Text("Storyboard", style: tabStyle),
            Text("MarketPlace", style: tabStyle),
          ],
        );
      },
    );
  }
}

class TestimonialWidget extends StatelessWidget {
  final List<Review> reviews;

  const TestimonialWidget({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        return ReviewCard(review: reviews[index]);
      },
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              review.reviewerName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              review.reviewDate,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < review.stars ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(review.text, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
