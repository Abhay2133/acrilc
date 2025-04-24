import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContinuationScreen extends StatefulWidget {
  @override
  State<ContinuationScreen> createState() => _ContinuationScreenState();
}

class _ContinuationScreenState extends State<ContinuationScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: OnboardingWrapper(
        showBack: false,
        title: 'Pick Your Username',
        subtitle: 'Choose a unique username for your Arclic profile',
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Username',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ),
        onContinue: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProfilePictureScreen()),
          );
        },
        onSkip: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProfilePictureScreen()),
          );
        },
      ),
    );
  }
}

class ProfilePictureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OnboardingWrapper(
      showBack: true,
      title: 'Add a Profile Picture',
      subtitle: 'Upload an image to personalize your Arclic profile',
      content: Container(
        height: 120,
        margin: EdgeInsets.symmetric(horizontal: 32),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(child: Text('Tap to upload an image')),
      ),
      onContinue: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => SelectCategoriesScreen()),
        );
      },
      onSkip: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => SelectCategoriesScreen()),
        );
      },
    );
  }
}

class SelectCategoriesScreen extends StatelessWidget {
  final List<String> categories = [
    "Digital Art", "Photography", "Illustration",
    "Graphic Design", "Painting", "Sculpture"
  ];

  @override
  Widget build(BuildContext context) {
    return OnboardingWrapper(
      showBack: true,
      title: 'Select Categories',
      subtitle: 'Choose categories that match your interests',
      content: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: categories
            .map((e) => Chip(
          label: Text(e),
          backgroundColor: Colors.grey.shade200,
        ))
            .toList(),
      ),
      onContinue: () {
        // TODO: Navigate to next part of the app
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Onboarding Completed!')),
        );
      },
      onSkip: () {
        // Same as Continue here
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Skipped to Home!')),
        );
      },
    );
  }
}

class OnboardingWrapper extends StatelessWidget {
  final bool showBack;
  final String title;
  final String subtitle;
  final Widget content;
  final VoidCallback onContinue;
  final VoidCallback onSkip;

  const OnboardingWrapper({
    super.key,
    required this.showBack,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.onContinue,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showBack)
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    SizedBox(height: 32),
                    Text(
                      title,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 24),
                    content,
                    SizedBox(height: 40),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: onContinue,
                      child: Text("CONTINUE", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    TextButton(
                      onPressed: onSkip,
                      child: Text("Skip", style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
