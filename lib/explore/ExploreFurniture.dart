import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import './categoryImageScreen.dart';

class FurnitureScreen extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {"title": "Bohemian", "image": "assets/bohemiancrop.jpg"},
    {"title": "Kids", "image": "assets/kids.jpg"},
    {"title": "Modern", "image": "assets/modern.jpg"},
    {"title": "Classic", "image": "assets/classic.jpg"},
  ];

  final Map<String, Map<String, List<String>>> categoryImages = {
    "Bohemian": {
      "Beds": [
        "assets/boho_bed_1.png",
        "assets/boho_bed_2.png",
        "assets/boho_bed_3.png"
      ],
      "Sofas": [
       "assets/boho_sofa_1.png",
        "assets/boho_sofa_2.png",
        "assets/boho_sofa_3.png"
      ],
      "waredrops":[
       "assets/boho_waredrobe_1.png",
        "assets/boho_waredrobe_2.png",
        "assets/boho_waredrobe_3.png"
      ]
    },
    "Kids": {
      "Beds": [
        "assets/kids_bed_1.png",
        "assets/kids_bed_2.png",
        "assets/kids_bed_3.png",
      ],
      "Sofas": [
        "assets/kids_sofa_1.png",
        "assets/kids_sofa_2.png",
        "assets/kids_sofa_3.png",
      ],
      "Wardrops": [
        "assets/kids_wardrop_1.png",
        "assets/kids_wardrop_2.png",
        "assets/kids_wardrop_3.png",
      ],
    },
    "Classic": {
      "Beds": [
        "assets/classic_bed_1.png",
        "assets/classic_bed_2.png",
        "assets/classic_bed_3.png",
      ],
      "Sofas": [
        "assets/classic_sofa_1.png",
        "assets/classic_sofa_2.png",
        "assets/classic_sofa_3.png",
      ],
    },
    "Modern": {
      "Beds": [
        "assets/modern_bed_1.png",
        "assets/modern_bed_2.png",
        "assets/modern_bed_3.png",
      ],
      "Sofas": [
        "assets/modern_sofa_1.png",
        "assets/modern_sofa_2.png",
        "assets/modern_sofa_3.png",
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/explore outer background.png"),
                fit: BoxFit.cover,
              ),
          ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  "Furniture\nin your style",
                  style: GoogleFonts.chivoMono(
                    textStyle: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Expanded(
                  child: MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          String selectedCategory = categories[index]["title"]!;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryImagesScreen(
                                categoryTitle: selectedCategory,
                                categoryImages: categoryImages[selectedCategory] ?? {},
                              ),
                            ),
                          );
                        },
                        child: CategoryCard(
                          title: categories[index]["title"]!,
                          imagePath: categories[index]["image"]!,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const CategoryCard({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.white.withOpacity(0.7),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}