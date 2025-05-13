import 'dart:ui';
//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'ServiceProvidersPage.dart';
import 'package:darak_app/home_page.dart'; // Import HomePage

class Utilities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Uti-Back.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0, bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Hello,",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        // Home Button (Image)
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => MyHomePage()),
                            );
                          },
                          child: Image.asset(
                            "assets/Darak.png", // Replace with your home icon image
                            width: 36,  // Adjust size as needed
                            height: 36,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "What are you looking for?",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 24),

                    // Staggered Grid Layout
                    Expanded(
                      child: SingleChildScrollView(
                        child: StaggeredGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          children: [
                            StaggeredGridTile.fit(
                              crossAxisCellCount: 1,
                              child: buildServiceCard(context, "Painting", "assets/painting.jpg", Icons.format_paint, height: 190),
                            ),
                            StaggeredGridTile.fit(
                              crossAxisCellCount: 1,
                              child: buildServiceCard(context, "Lighting", "assets/lighting.jpg", Icons.lightbulb, height: 250),
                            ),
                            StaggeredGridTile.fit(
                              crossAxisCellCount: 1,
                              child: buildServiceCard(context, "Cleaning", "assets/cleaning.jpg", Icons.cleaning_services, height: 240),
                            ),
                            StaggeredGridTile.fit(
                              crossAxisCellCount: 1,
                              child: buildServiceCard(context, "Gardening", "assets/gardening.jpg", Icons.grass, height: 180),
                            ),
                        
                            // Full-width Furniture Assembly
                            StaggeredGridTile.count(
                              crossAxisCellCount: 2, // Full width
                              mainAxisCellCount: 1, // Proper height
                              child: buildServiceCard(context, "Furniture Assembly", "assets/furniture.jpg", Icons.chair, height: 160),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to create a service card with blur effect
  Widget buildServiceCard(BuildContext context, String title, String imagePath, IconData icon, {double height = 150}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceProvidersPage(serviceName: title),
          ),
        );
      },
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Blurred bottom part
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.6)],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Text & Icon
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




