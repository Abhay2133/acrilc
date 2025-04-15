import 'package:acrilc/widgets/buttons.dart';
import 'package:flutter/material.dart';

class FortePage extends StatefulWidget {
  const FortePage({super.key});

  @override
  State<FortePage> createState() => _FortePageState();
}

class _FortePageState extends State<FortePage> {
  late List<String> selectedFortes; // = List<String>.empty();
  late List<String> filteredFortes;
  final List<String> forteOptions = [
    "Realism",
    "Impressionism",
    "Abstract",
    "Surrealism",
    "Expressionism",
    "Cubism",
    "Minimalism",
    "Pop Art",
    "Art Nouveau",
    "Art Deco",
    "Futurism",
    "Baroque",
    "Rococo",
    "Gothic",
    "Neoclassicism",
    "Romanticism",
    "Street Art",
    "Graffiti",
    "Digital Art",
    "Pixel Art",
    "Calligraphy",
    "Tattoo Art",
    "Watercolor",
    "Acrylic Painting",
    "Oil Painting",
    "Sculpture",
    "Woodworking",
    "Metal Craft",
    "Ceramics",
    "Glass Art",
    "Textile Art",
    "Paper Craft",
    "Origami",
    "Mosaic Art",
    "Illustration",
    "Comic Art",
    "Anime/Manga",
    "Typography",
    "Concept Art",
    "Fantasy Art",
  ];

  @override
  void initState() {
    super.initState();
    selectedFortes = List<String>.empty(growable: true);
    filteredFortes = List.from(forteOptions);
  }

  void _filterFortes(String query) {
    setState(() {
      filteredFortes =
          forteOptions
              .where(
                (forte) => forte.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Fortes")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose your fortes:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),

            /// **Search Bar**
            TextField(
              decoration: InputDecoration(
                hintText: "Search fortes...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: _filterFortes,
            ),

            const SizedBox(height: 10),

            /// **Filtered Chips**
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children:
                      filteredFortes.map((forte) {
                        bool isSelected = selectedFortes.contains(forte);
                        return ChoiceChip(
                          label: Text(forte),
                          selected: isSelected,
                          selectedColor: Colors.orange.shade500,
                          backgroundColor: Colors.transparent,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedFortes.add(forte);
                              } else {
                                selectedFortes.remove(forte);
                              }
                            });
                          },
                        );
                      }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// **Save Button**
            PrimaryButton(
              text: "Save",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
