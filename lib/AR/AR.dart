// import 'package:flutter/material.dart';


// class CategoryScreen extends StatelessWidget {
//   final List<String> categories = [
//     'Chairs', 'Sofa', 'Side lamps', 'Beds', 'Mirrors',
//     'Side tables', 'Coffee tables', 'Dining table',
//     'Dressing table', 'Curtains', 'Wardrobe'
//   ];

//   final Map<String, List<String>> categoryItems = {
//     "Chairs": [
//       "Wooden armrest",
//       "Grey sofa",
//       "Modern beige chair",
//       "Red chair",
//       "Modern chair",
//     ],
//     "Sofa": [
//       "Leather Sofa",
//       "White Corner Sofa",
//     ],
//   };

//   void _showBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) {
//         return BottomSheetWidget(
//           categories: categories,
//           categoryItems: categoryItems,
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFDAD5D1),
//       // appBar: AppBar(
//       //   backgroundColor: Colors.white,
//       //   elevation: 0,
//       //   title: const Text(
//       //     "Categories",
//       //     style: TextStyle(color: Colors.black),
//       //   ),
//       //   centerTitle: true,
//       // ),
//       body: const Center(
//         child: Text(
//           "Tap + to view items",
//           style: TextStyle(fontSize: 18, color: Colors.black54),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: const Color(0xFFE4E2DE),
//         onPressed: () {
//           _showBottomSheet(context);
//         },
//         child: const Icon(Icons.add, color: Colors.black),
//       ),
//     );
//   }
// }

// class BottomSheetWidget extends StatefulWidget {
//   final List<String> categories;
//   final Map<String, List<String>> categoryItems;

//   const BottomSheetWidget({
//     required this.categories,
//     required this.categoryItems,
//     super.key,
//   });

//   @override
//   _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
// }

// class _BottomSheetWidgetState extends State<BottomSheetWidget> {
//   int _categoryIndex = 0;
//   late PageController _pageController;
//   double _sheetSize = 0.4;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: _categoryIndex);
//   }

//   void _onPageChanged(int index) {
//     setState(() {
//       _categoryIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onVerticalDragUpdate: (details) {
//         setState(() {
//           _sheetSize += details.primaryDelta! / 300;
//           _sheetSize = _sheetSize.clamp(0.3, 0.8);
//         });
//       },
//       child: DraggableScrollableSheet(
//         initialChildSize: _sheetSize,
//         minChildSize: 0.3,
//         maxChildSize: 0.8,
//         expand: false,
//         builder: (context, scrollController) {
//           return Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//             ),
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 50,
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: List.generate(widget.categories.length, (index) {
//                         return _buildCategoryButton(widget.categories[index], index);
//                       }),
//                     ),
//                   ),
//                 ),
//                 const Divider(),
//                 Expanded(
//                   child: PageView.builder(
//                     controller: _pageController,
//                     onPageChanged: _onPageChanged,
//                     itemCount: widget.categories.length,
//                     itemBuilder: (context, index) {
//                       return _buildCategoryContent(widget.categories[index], scrollController);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildCategoryButton(String title, int index) {
//     bool isSelected = _categoryIndex == index;

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         TextButton(
//           onPressed: () {
//             _pageController.jumpToPage(index);
//           },
//           child: Text(
//             title,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
//               color: isSelected ? Colors.black : Colors.black54,
//             ),
//           ),
//         ),
//         AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           height: 2,
//           width: 20,
//           color: isSelected ? Colors.black : Colors.transparent,
//         ),
//       ],
//     );
//   }

//   Widget _buildCategoryContent(String category, ScrollController scrollController) {
//     List<String> items = widget.categoryItems[category] ?? [];

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: GridView.builder(
//         controller: scrollController, // Ensures scrolling works inside the bottom sheet
//         itemCount: items.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 0.8,
//           crossAxisSpacing: 16,
//           mainAxisSpacing: 16,
//         ),
//         itemBuilder: (context, index) {
//           return _buildGridItem(items[index]);
//         },
//       ),
//     );
//   }

//   Widget _buildGridItem(String itemName) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Color(0xFFDAD5D1),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       alignment: Alignment.center,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Text(
//           itemName,
//           textAlign: TextAlign.center,
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//         ),
//       ),
//     );
//   }
// }
