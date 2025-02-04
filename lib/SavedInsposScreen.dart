import 'package:flutter/material.dart';

class SavedInsposScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = [
      'assets/image1.png', // Replace with your image paths
      'assets/image2.png',
      'assets/image3.png',
    ];

    return Scaffold(
      body: Column(
        children: [
          // Background Section
          Container(
            height: 200, // Adjust height for background
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('waves.png'), // Replace with your background image
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
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20), // Rounded corners at the top
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two columns
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1, // Square-shaped grid items
                  ),
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    return _buildGridItem(imageUrls[index]);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build each grid item
  Widget _buildGridItem(String imageUrl) {
    return Stack(
      children: [
        // Image container
        ClipRRect(
          borderRadius: BorderRadius.circular(15), // Rounded corners for images
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        // Heart icon
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                // Add your "save" or "favorite" logic here
              },
            ),
          ),
        ),
      ],
    );
  }
}
