import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:darak_app/explore/categoryImageScreen.dart';


class SavedInsposScreen extends StatefulWidget {

  @override
_SavedInsposState createState() => _SavedInsposState();
}

class _SavedInsposState extends State<SavedInsposScreen>  {
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

    return Scaffold(
      body: Column(
        children: [
          // Background Section
          Container(
            height: 120, 
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/waves.png'), // Replace with your background image
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 0),
                    Text(
                      'Saved Inspos',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Grid Section
          Expanded(
            // Wrap the MasonryGridView with Expanded to make it fill the available space
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                // Get the number of images for the selected sub-category
                itemCount: _favoritesService.favorites.length,
                itemBuilder: (context, index) {
                  final URL = _favoritesService.favorites.elementAt(index);
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
    );
  }
}
