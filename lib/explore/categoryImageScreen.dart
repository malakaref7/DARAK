// ignore_for_file: prefer_const_constructors

import 'package:darak_app/explore/ExploreFurniture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Create a service class to handle favorites
class FavoritesService {
  static const _key = 'favorites';
  final Set<String> _favorites = {};

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_key) ?? [];
    _favorites.addAll(favorites);
  }

  Future<void> toggleFavorite(String imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    if (_favorites.contains(imagePath)) {
      _favorites.remove(imagePath);
    } else {
      _favorites.add(imagePath);
    }
    await prefs.setStringList(_key, _favorites.toList());
  }

  bool isFavorite(String imagePath) => _favorites.contains(imagePath);


  Set<String> get favorites => _favorites;

}

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

  final FavoritesService _favoritesService = FavoritesService();

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    await _favoritesService.loadFavorites();
    if (mounted) setState(() {});
  }

  Future<void> _toggleFavorite(String imagePath) async {
    await _favoritesService.toggleFavorite(imagePath);
    if (mounted) setState(() {});

  }


  @override
  Widget build(BuildContext context) {
    final selectedSubCategory = widget.category.subCategories[selectedSubCategoryIdx];
    return Scaffold(
      body: Container(
        // background color
        color: Color(0xFFF6F3F1),
        child: Stack(
          children: [
            // Positioned.fill(
            //   // background image
            //   child: Image.asset(
            //     "assets/waves.png",
            //     fit: BoxFit.cover,
            //   ),
            // ),
            SafeArea(
              // SafeArea to avoid notches and system UI overlaps
              child: Column(
                // main column for the category images screen with sub-categories and images
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Align the text to the left
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        ), // Add padding to the text
                    child: SingleChildScrollView(
                      clipBehavior: Clip.none,
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
                      padding: const EdgeInsets.all(12.0),
                      child: MasonryGridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        // Get the number of images for the selected sub-category
                        itemCount: selectedSubCategory.images.length,
                        itemBuilder: (context, index) {
                          final URL = 'https://raw.githubusercontent.com/NadaHenedy/ar_data/refs/heads/main/${widget.category.path}/${selectedSubCategory.path}/${selectedSubCategory.images[index]}';
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: ImageCard(
                              imagePath: URL,
                              isFavorite: _favoritesService.isFavorite(URL),
                              onFavoritePressed: () => _toggleFavorite(URL),
                            )
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


class ImageCard extends StatelessWidget {
  final String imagePath;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;

  const ImageCard({
    required this.imagePath,
    this.isFavorite = false,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFDAD5D1), // Background color
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // Image part
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child:    // Image part
              Image.network(
                imagePath, // Use the provided path directly
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),

            // Favorite button
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: onFavoritePressed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}