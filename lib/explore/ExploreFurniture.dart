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
      path: "bohemian style",
      name: "Bohemian",
      image_path: "category_images/bohemian.jpeg",
      subCategories: [
        SubCategory(path: "beds", name: "BEDS", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "buffet", name: "BUFFET", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "chairs", name: "CHAIRS", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "coffee tables", name: "COFFEE TABLES", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "curtains", name: "CURTAINS", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "dining table", name: "DINING TABLE", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "2.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "dresssing tables", name: "DRESSING TABLES", images: ["1.png", "2.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "mirrors", name: "MIRRORS", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "21.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "side lamps", name: "SIDE LAMPS", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "side table", name: "SIDE TABLE", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "21.png", "22.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "sofa", name: "SOFA", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "21.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "wardrobe", name: "WARDROBE", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
      ],
    ),
    Category(
      path: "classic style",
      name: "Classic",
      image_path: "category_images/classic.jpeg",
      subCategories: [
        SubCategory(path: "beds", name: "BEDS", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "buffet", name: "BUFFET", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "chairs", name: "CHAIRS", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "21.png", "22.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "coffee tables", name: "COFFEE TABLES", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "curtains", name: "CURTAINS", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "dining table", name: "DINING TABLE", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "dresssing tables", name: "DRESSING TABLES", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "mirrors", name: "MIRRORS", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "side lamps", name: "SIDE LAMPS", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "side table", name: "SIDE TABLE", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "sofa", name: "SOFA", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "wardrobe", name: "WARDROBE", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
      ],
    ),
    Category(
      path: "kids",
      name: "Children",
      image_path: "category_images/kids.jpeg",
      subCategories: [
        SubCategory(path: "beds", name: "BEDS", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "21.png", "22.png", "23.png", "25.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "chairs", name: "CHAIRS", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "curtains", name: "CURTAINS", images: ["1.png", "10.png" ,"2.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "dressing_tables", name: "DRESSING TABLES", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "mirrors", name: "MIRRORS", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "side_lamps", name: "SIDE LAMPS", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "side_tables", name: "SIDE TABLES", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "sofa", name: "SOFA", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "studying_desks", name: "STUDYING DESKS", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "wardrobes", name: "WARDROBES", images: ["1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
      ],
    ),
    Category(
      path: "modern style",
      name: "Modern",
      image_path: "category_images/modern.jpeg",
      subCategories: [
        SubCategory(path: "Beds", name: "BEDS", images: ["0.png", "1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "Buffet", name: "BUFFET", images: ["0.png", "1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "Chairs", name: "CHAIRS", images: ["0.png", "1.png", "10.png", "11.png", "12.png", "13.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "21.png", "22.png", "23.png", "24.png", "25.png", "26.png", "27.png", "28.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "coffee tables", name: "COFFEE TABLES", images: ["0.png", "1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "21.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "Dressing tables", name: "DRESSING TABLES", images: ["0.png", "1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "Lamps", name: "LAMPS", images: ["0.png", "1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "21.png", "22.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "mirror", name: "MIRROR", images: ["0.png", "1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "21.png", "22.png", "23.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "side tables", name: "SIDE TABLES", images: ["0.png", "1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "Sofas", name: "SOFAS", images: ["0.png", "1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "Tables", name: "TABLES", images: ["0.png", "1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png", "16.png", "17.png", "18.png", "19.png", "2.png", "20.png", "21.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
        SubCategory(path: "Wardrobe", name: "WARDROBE", images: ["0.png", "1.png", "10.png", "11.png", "12.png", "13.png", "14.png", "2.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"]),
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