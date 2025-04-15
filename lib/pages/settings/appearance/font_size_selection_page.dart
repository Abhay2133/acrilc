import 'package:acrilc/constants/colors.dart';
import 'package:acrilc/widgets/buttons.dart' show PrimaryButton;
import 'package:flutter/material.dart';

class FontSizeSelectionPage extends StatefulWidget {
  final double currentFontSize; // Default font size

  const FontSizeSelectionPage({super.key, required this.currentFontSize});

  @override
  State<FontSizeSelectionPage> createState() => _FontSizeSelectionPageState();
}

class _FontSizeSelectionPageState extends State<FontSizeSelectionPage> {
  late double fontSize;

  @override
  void initState() {
    super.initState();
    fontSize = widget.currentFontSize;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Font Size")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// **Font Size Slider**
            Slider(
              activeColor: AppColor.primaryColor,
              value: fontSize,
              min: 12,
              max: 24,
              divisions: 6,
              label: fontSize.round().toString(),
              onChanged: (value) {
                setState(() {
                  fontSize = value;
                });
              },
            ),

            /// **Live Preview Text**
            const SizedBox(height: 20),
            Text(
              "This is a preview text.",
              style: TextStyle(fontSize: fontSize),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PrimaryButton(
          text: "Save",
          onPressed: () {
            Navigator.pop(context, fontSize);
          },
        ),
      ),
    );
  }
}
