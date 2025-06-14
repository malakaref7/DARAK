import 'package:darak_app/explore/categoryImageScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';



void main() {
  runApp(MaterialApp(
    home: FurnitureScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
class Category {
  String path;
  String name;
  String image_path;
  List<SubCategory> subCategories;

  Category({required this.path, required this.name, required this.image_path, required this.subCategories});
}

class SubCategory {
  String path;  // New path attribute
  String name;  // Name will be in uppercase
  List<String> images;

  SubCategory({required this.path, required this.name, required this.images});
}

class FurnitureScreen extends StatelessWidget {
  // define the structure of the folders on github for easy access
  final List<Category> categoryList = [
    Category(
      path: "Rooms_final/boho",
      name: "Bohemian",
      image_path: "category_images/bohemian.jpeg",
      subCategories: [
        SubCategory(
          path: "bedrooms",
          name: "BEDROOMS",
          images: [
            "1.jpg", "10.jpg", "11.jpg", "12.jpg", "13.jpg", "14.jpg", "15.jpg", "16.jpg", "17.jpg", "18.jpg", "19.jpg", "2.jpg", "20.jpg", "21.jpg", "22.jpg", "23.jpg", "24.jpg", "25.jpg", "26.jpg", "27.jpg", "28.jpg", "29.jpg", "3.jpg", "30.jpg", "5.jpg", "6.jpg", "7.jpg", "8.jpg", "9.jpg"
          ],
        ),
        SubCategory(
          path: "kitchens",
          name: "KITCHENS",
          images: [
            "1.jpg", "10.jpg", "11.jpg", "12.jpg", "13.jpg", "14.jpg", "15.jpg", "16.jpg", "17.jpg", "18.jpg", "19.jpg", "2.jpg", "20.jpg", "21.jpg", "22.jpg", "23.jpg", "24.jpg", "25.jpg", "26.jpg", "27.jpg", "28.jpg", "29.jpg", "3.jpg", "30.jpg", "4.jpg", "5.jpg", "6.jpg", "7.jpg", "8.jpg", "9.jpg"
          ],
        ),
        SubCategory(
          path: "living rooms",
          name: "LIVING ROOMS",
          images: [
            "10.jpg", "11.jpg", "12.jpg", "13.jpg", "14.jpg", "15.jpg", "16.jpg", "17.jpg", "18.jpg", "19.jpg", "20.jpg", "21.jpg", "22.jpg", "23.jpg", "24.jpg", "25.jpg", "26.jpg", "27.jpg", "28.jpg", "29.jpg", "30.jpg"
          ],
        ),
      ],
    ),
    Category(
      path: "Rooms_final/children",
      name: "Children",
      image_path: "category_images/kids.jpeg",
      subCategories: [
        SubCategory(
          path: "bedrooms",
          name: "BEDROOMS",
          images: [
            "10.jpg", "11.jpg", "12.jpg", "13.jpg", "14.jpg", "15.jpg", "16.jpg", "17.jpg", "18.jpg", "19.jpg", "20.jpg", "21.jpg", "22.jpg", "23.jpg", "24.jpg", "25.jpg", "26.jpg", "27.jpg", "28.jpg", "29.jpg", "30.jpg"
          ],
        ),
      ],
    ),
    Category(
      path: "Rooms_final/classic",
      name: "classic",
      image_path: "category_images/classic.jpeg",
      subCategories: [
        SubCategory(
          path: "bedrooms",
          name: "BEDROOMS",
          images: [
            "10.jpg", "11.jpg", "12.jpg", "13.jpg", "14.jpg", "15.jpg", "16.jpg", "17.jpg", "18.jpg", "19.jpg", "20.jpg", "21.jpg", "22.jpg", "23.jpg", "24.jpg", "25.jpg", "26.jpg", "27.jpg", "28.jpg", "29.jpg", "30.jpg"
          ],
        ),
        SubCategory(
          path: "kitchens",
          name: "KITCHENS",
          images: [
            "10.jpg", "11.jpg", "12.jpg", "13.jpg", "14.jpg", "15.jpg", "16.jpg", "17.jpg", "18.jpg", "19.jpg", "20.jpg", "21.jpg", "22.jpg", "23.jpg", "24.jpg", "25.jpg", "26.jpg", "27.jpg", "28.jpg", "29.jpg", "30.jpg"
          ],
        ),
        SubCategory(
          path: "livinig rooms",
          name: "LIVINIG ROOMS",
          images: [
            "10.jpg", "11.jpg", "12.jpg", "13.jpg", "14.jpg", "15.jpg", "16.jpg", "17.jpg", "18.jpg", "19.jpg", "20.jpg", "21.jpg", "22.jpg", "23.jpg", "24.jpg", "25.jpg", "26.jpg", "27.jpg", "28.jpg", "29.jpg", "30.jpg"
          ],
        ),
      ],
    ),
    Category(
      path: "Rooms_final/modern",
      name: "Modern",
      image_path: "category_images/modern.jpeg",
      subCategories: [
        SubCategory(
          path: "bedrooms",
          name: "BEDROOMS",
          images: [
            "10.jpg", "11.jpg", "12.jpg", "13.jpg", "14.jpg", "15.jpg", "16.jpg", "17.jpg", "18.jpg", "19.jpg", "20.jpg", "21.jpg", "22.jpg", "23.jpg", "24.jpg", "25.jpg", "26.jpg", "27.jpg", "28.jpg", "29.jpg", "30.jpg"
          ],
        ),
        SubCategory(
          path: "kitchens",
          name: "KITCHENS",
          images: [
            "10.jpg", "11.jpg", "12.jpg", "13.jpg", "14.jpg", "15.jpg", "16.jpg", "17.jpg", "18.jpg", "19.jpg", "20.jpg", "21.jpg", "22.jpg", "23.jpg", "24.jpg", "25.jpg", "26.jpg", "27.jpg", "28.jpg", "29.jpg", "30.jpg"
          ],
        ),
        SubCategory(
          path: "living rooms",
          name: "LIVING ROOMS",
          images: [
            "10.jpg", "11.jpg", "12.jpg", "13.jpg", "14.jpg", "15.jpg", "16.jpg", "17.jpg", "18.jpg", "19.jpg", "20.jpg", "21.jpg", "22.jpg", "23.jpg", "24.jpg", "25.jpg", "26.jpg", "27.jpg", "28.jpg", "29.jpg", "30.jpg"
          ],
        ),
      ],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              "assets/explore outer background.png",
              fit: BoxFit.cover,
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40), // Add spacing at the top
                // title text
                Text(
                  "Furniture\nin your style",
                  style: GoogleFonts.chivo(
                    textStyle: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Add spacing between title and categories

                // Categories
                Expanded(
                  // Wrap the MasonryGridView with Expanded to make it fill the available space
                  child: MasonryGridView.count(
                    crossAxisCount: 2, // Number of columns
                    mainAxisSpacing: 10, // Spacing between rows
                    crossAxisSpacing: 10, // Spacing between columns
                    itemCount: categoryList.length, // Number of our categories list (bohemian, kids, modern, classic)
                    itemBuilder: (context, index) { // Build our categories cards using our CategoryCard widget
                      return GestureDetector( // Add a GestureDetector to handle taps
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryImagesScreen(
                                category: categoryList[index]
                              ),
                            ),
                          );
                        },
                        child: CategoryCard(
                          title: categoryList[index].name,
                          imagePath: categoryList[index].image_path,
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

  // Constructor for the CategoryCard widget
  const CategoryCard({
    required this.title,
    required this.imagePath
  });

  @override
  Widget build(BuildContext context) {
    return Material( // Wrap the Material widget around the Card widget to add elevation and rounded corners
      elevation: 5,
      borderRadius: BorderRadius.circular(16),
      child: ClipRRect( // Clip the image to the rounded corners
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.network(
              "https://raw.githubusercontent.com/NadaHenedy/ar_data/refs/heads/main/$imagePath" ,
              fit: BoxFit.cover,
              width: double.infinity, // Make the image fill the available width
            ),
            Positioned( // Positioned widget to place the title text on top of the image
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