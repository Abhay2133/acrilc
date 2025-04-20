// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:go_router/go_router.dart';
//
// class UserPortfolio extends StatelessWidget {
//   final String userId;
//
//   const UserPortfolio({super.key, required this.userId});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             context.pop();
//           },
//           icon: const Icon(Icons.arrow_back_ios_rounded),
//         ),
//       ),
//       body: Center(child: Text("$userId")),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserPortfolio extends StatelessWidget {
  final String userId;

  const UserPortfolio({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture and Name
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/profile.jpg"), // Placeholder
            ),
            const SizedBox(height: 8),
            Text(
              "Alexis Luna",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 4),
            Text(
              "San Francisco, CA",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text("@alexisluna", style: Theme.of(context).textTheme.titleMedium),

            const SizedBox(height: 12),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {},
                  child: const Text("Request Services"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  child: const Text("Message"),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Portfolio
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Portfolio",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildPortfolioCard(
                    context,
                    "Lost in the woods – Oil on Canvas",
                    "\$500",
                  ),
                  _buildPortfolioCard(
                    context,
                    "Summer Breeze on Paper",
                    "\$300",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Forte
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Forte",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildForteCard(context, "Abstract Art", "Expert"),
                  _buildForteCard(context, "Impressionist", "Advanced"),
                  _buildForteCard(context, "Watercolor", "Expert"),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Story
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Story Behind the Art",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "I am inspired by nature and love to paint landscapes. My style is a blend of impressionism and abstract art.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 24),

            // Featured Works
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Featured Works",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                6,
                (index) => _buildFeaturedWorkCard(context),
              ),
            ),

            const SizedBox(height: 24),

            // Testimonials
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Testimonials",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildTestimonialCard(context, "Amazon", "Jan 1, 2022", 5),
                const SizedBox(width: 10),
                _buildTestimonialCard(context, "Google", "Dec 15, 2021", 4),
              ],
            ),

            const SizedBox(height: 24),

            // Contact
            ListTile(
              title: Text(
                "Contact Me",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              subtitle: Text(
                "Send an Email",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: Icon(Icons.arrow_forward),
            ),
          
            ListTile(
              title: Text(
                "Share portfolio link",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              subtitle: Text(
                "alexisluna/portfolio/acrilcart",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPortfolioCard(BuildContext context, String title, String price) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(color: Colors.grey[400]),
          ), // Placeholder image
          const SizedBox(height: 8),
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
          Text(price, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }

  Widget _buildForteCard(BuildContext context, String title, String level) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 4),
          Text(
            "Skill Level: $level",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedWorkCard(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildTestimonialCard(
    BuildContext context,
    String brand,
    String date,
    int stars,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              Icons.business,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 8),
            Text("$brand -", style: Theme.of(context).textTheme.bodyMedium),
            Text(date, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  size: 16,
                  color: index < stars ? Colors.amber : Colors.grey,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
