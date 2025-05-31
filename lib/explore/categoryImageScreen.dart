import 'package:darak_app/explore/ExploreFurniture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

//create class for category images screen
class CategoryImagesScreen extends StatefulWidget {
  // create constructor for category images screen
  final Category category;

  const CategoryImagesScreen({required this.category});

  //create state for category images screen
  @override
  _CategoryImagesScreenState createState() => _CategoryImagesScreenState();
}

// create state for category images screen
class _CategoryImagesScreenState extends State<CategoryImagesScreen> {
  int selectedSubCategoryIdx = 0; // Initialize the selected sub-category index

  @override
  Widget build(BuildContext context) {
    final selectedSubCategory = widget.category.subCategories[selectedSubCategoryIdx];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD7C6BD),
        title: Text(
          // Display the category title
          widget.category.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: Container(
        // background color
        color: const Color(0xFFFEFFFE),
        child: Stack(
          children: [
            Positioned.fill(
              // background image
              child: Image.asset(
                "assets/wave-haikei (3).png",
                fit: BoxFit.cover,
                width: 90.0,
              ),
            ),
            SafeArea(
              // SafeArea to avoid notches and system UI overlaps
              child: Column(
                // main column for the category images screen with sub-categories and images
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align the text to the left
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0), // Add padding to the text
                    child: SingleChildScrollView(
                      // Add a SingleChildScrollView to scroll horizontally
                      scrollDirection: Axis.horizontal,
                      child: Row(// Row to display the sub-categories
                          children: [
                        //for Loop through the sub-categories
                        for (var i = 0;
                            i < widget.category.subCategories.length;
                            i++)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                // Update the selected sub-category index
                                selectedSubCategoryIdx = i;
                              });
                            },
                            child: Text(
                              // Display the sub-category name
                              widget.category.subCategories[i].name,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: selectedSubCategoryIdx == i
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                      ]),
                    ),
                  ),
                  Expanded(
                    // Wrap the MasonryGridView with Expanded to make it fill the available space
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: MasonryGridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        // Get the number of images for the selected sub-category
                        itemCount: selectedSubCategory.images.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              "https://raw.githubusercontent.com/NadaHenedy/ar_data/refs/heads/main/explore_images/${widget.category.path}/${selectedSubCategory.path}/${selectedSubCategory.images[index]}",
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
