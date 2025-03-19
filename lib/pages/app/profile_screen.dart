import 'package:acrillic/util.dart';
import 'package:acrillic/widgets/circular_tag.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ProfileSection(), ProfileCards(), ActionButtons()],
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

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
              child: Container(
                child: Container(
                  // color: Colors.green,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "John Doe",
                        style:
                            Theme.of(
                              context,
                            ).textTheme.headlineLarge, // Uses theme
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Flutter Developer",
                        style:
                            Theme.of(
                              context,
                            ).textTheme.titleMedium, // Uses theme
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
  const ProfileCards({super.key});

  @override
  Widget build(BuildContext context) {
    double gap = 8;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF242424),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 80,
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
            child: InkWell(
              onTap: () {
                alert(context, "Support clicked");
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xFFE34A1C),
                  border: Border.all(color: Colors.black26, width: 2),
                ),
                alignment: Alignment.center,
                height: 50,
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
            child: InkWell(
              onTap: () {
                alert(context, "Message clicked");
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xFFE34A1C),
                  border: Border.all(color: Colors.black26, width: 2),
                ),
                alignment: Alignment.center,
                height: 50,
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
