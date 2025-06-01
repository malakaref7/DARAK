import 'package:flutter/material.dart';
import 'glb_files.dart';
import '../services/github_glb_fetcher.dart';

class BottomSheetWidget extends StatefulWidget {
  final List<String> categories;
  final void Function(String glbUrl) onModelSelected;
  const BottomSheetWidget({
    required this.categories,
    required this.onModelSelected,
    super.key,
  });

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  int _categoryIndex = 0;
  late PageController _pageController;
  double _sheetSize = 0.4;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _categoryIndex);
  }

  void _onPageChanged(int index) {
    setState(() {
      _categoryIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        setState(() {
          _sheetSize += details.primaryDelta! / 300;
          _sheetSize = _sheetSize.clamp(0.3, 0.8);
        });
      },
      child: DraggableScrollableSheet(
        initialChildSize: _sheetSize,
        minChildSize: 0.3,
        maxChildSize: 0.8,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(widget.categories.length, (index) {
                        return _buildCategoryButton(widget.categories[index], index);
                      }),
                    ),
                  ),
                ),
                const Divider(),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: widget.categories.length,
                    itemBuilder: (context, index) {
                      return _buildCategoryContent(widget.categories[index], scrollController);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryButton(String title, int index) {
    bool isSelected = _categoryIndex == index;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () {
            _pageController.jumpToPage(index);
          },
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? Colors.black : Colors.black54,
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 2,
          width: 20,
          color: isSelected ? Colors.black : Colors.transparent,
        ),
      ],
    );
  }

  Widget _buildCategoryContent(String category, ScrollController scrollController) {
    return FutureBuilder<List<GlbFile>>(
      future: fetchGlbFilesForCategory(category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final files = snapshot.data ?? [];
        
        if (files.isEmpty) {
          return Center(child: Text('No .glb files found.'));
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            controller: scrollController,
            itemCount: files.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              return _buildGridItem(files[index]);
            },
          ),
        );
      },
    );
  }

  Widget _buildGridItem(GlbFile file) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFDAD5D1),
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: file.thumbnailUrl != null
          ? GestureDetector(
              onTap: () {
                widget.onModelSelected(file.downloadUrl); // <-- USE THE CALLBACK
                
              },
              child: Image.network(
                file.thumbnailUrl!,
                 fit: BoxFit.contain,
              ),
            )
          : Icon(Icons.image_not_supported),
    );
  }
}
