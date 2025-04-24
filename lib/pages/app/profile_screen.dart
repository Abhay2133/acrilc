import 'package:acrilc/models/user.dart';
import 'package:acrilc/services/user_service.dart';
import 'package:acrilc/util.dart';
import 'package:acrilc/widgets/circular_tag.dart';
import 'package:flutter/material.dart';

import 'horizontal_slider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<UserData?> _userFuture;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  void _fetchUser() {
    setState(() {
      _userFuture = UserService.getCurrentUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserData?>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text("Loading..."));
        } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Failed to load user.'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _fetchUser,
                  child: Text('Retry', style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
          );
        } else {
          final user = snapshot.data!;
          return ProfileWidget(userData: user);
        }
      },
    );
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
  final UserData userData;
  const ProfileWidget({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    List<Review> reviews = [
      Review(reviewerName: "Alice Johnson", reviewDate: "March 20, 2025", stars: 5, text: "Amazing service! Highly recommended for anyone looking for quality work."),
      Review(reviewerName: "David Smith", reviewDate: "March 18, 2025", stars: 4, text: "Great experience overall. A few minor improvements would make it perfect."),
      Review(reviewerName: "Emily Carter", reviewDate: "March 15, 2025", stars: 5, text: "Absolutely fantastic! The team went above and beyond my expectations."),
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileSection(
            profilePicture: userData.profilePicture ?? "",
            name: userData.fullName ?? "",
            bio: userData.bio ?? "",
          ),
          ProfileCards(),
          ActionButtons(),
          const SizedBox(height: 20),
          const HorizontalSlider(),     // slider for showcase , storyboard , marketlace
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Testimonials", style: Theme.of(context).textTheme.headlineLarge),
              ],
            ),
          ),
          ...reviews.map((review) => ReviewCard(review: review)).toList(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE34A1C),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
              ),
              onPressed: () {
                alert(context, "Portfolio coming soon!");
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  "Portfolio",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
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

  const ProfileSection({super.key, required this.profilePicture, required this.name, required this.bio});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/profile-banner.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 4),
                  Text(bio, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6.0,
                    runSpacing: 4.0,
                    children: const [
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
        Positioned(
          right: 20,
          top: 80,
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white54, width: 3),
              image: const DecorationImage(
                image: AssetImage('assets/images/profile-pic.png'),
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
  const ProfileCards({super.key});

  @override
  Widget build(BuildContext context) {
    double gap = 8;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              card("Supporters", "15K", context),
              SizedBox(width: gap),
              card("Supporting", "190", context),
              SizedBox(width: gap),
              card("Posts", "40", context),
            ],
          ),
          SizedBox(height: gap),
          Row(
            children: [
              card("Patrons", "422", context),
              SizedBox(width: gap),
              card("Community", "150K", context),
            ],
          ),
        ],
      ),
    );
  }

  Widget card(String title, String value, BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
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
                backgroundColor: const Color(0xFFE34A1C),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
              ),
              onPressed: () => alert(context, "Support Clicked"),
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: const Text("Support", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE34A1C),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
              ),
              onPressed: () => alert(context, "Message Clicked"),
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: const Text("Message", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Review review;
  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(review.reviewerName, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Row(
              children: List.generate(
                5,
                    (index) => Icon(
                  Icons.star,
                  color: index < review.stars ? Colors.orange : Colors.grey,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(review.reviewDate, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            Text(review.text, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}