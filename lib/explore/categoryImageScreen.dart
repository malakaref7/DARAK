import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoryImagesScreen extends StatefulWidget {
  final String categoryTitle;
  final Map<String, List<String>> categoryImages;

  const CategoryImagesScreen({
    required this.categoryTitle,
    required this.categoryImages,
  });

  @override
  _CategoryImagesScreenState createState() => _CategoryImagesScreenState();
}

class _CategoryImagesScreenState extends State<CategoryImagesScreen> {
  String selectedSubCategory = "";

  @override
  void initState() {
    super.initState();
    selectedSubCategory = widget.categoryImages.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB6ABA4),
        title: Text(
          widget.categoryTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFFFEFFFE),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/wave-haikei (3).png",
                fit: BoxFit.cover,
                width: 90.0,
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: widget.categoryImages.keys.map((subCategory) {
                          return TextButton(
                            onPressed: () {
                              setState(() {
                                selectedSubCategory = subCategory;
                              });
                            },
                            child: Text(
                              subCategory,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: selectedSubCategory == subCategory ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: MasonryGridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        itemCount: widget.categoryImages[selectedSubCategory]?.length ?? 0,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              widget.categoryImages[selectedSubCategory]![index],
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
