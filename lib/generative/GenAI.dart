import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GenAI extends StatefulWidget {
  @override
  _GenAIState createState() => _GenAIState();
}

class _GenAIState extends State<GenAI> {
  // ignore: unused_field
  String? _selectedRoomType;
  String? selectedStyle;
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  List<String> roomStyles = ["Modern", "Boho", "Classic", "Children"];

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      print("Image Path: ${image.path}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF6F3F1), // Very Light Brown
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// **Header Section**
                Stack(
                  children: [
                    /// **Main Header Row (Back Button & Title)**
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// **Back Button & Title**
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// **Back Button**
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Image.asset(
                                      'assets/Darak.png',
                                      width: 35,
                                      height: 35,
                                    ),
                                  ),
                                ),
      
                                SizedBox(height: 8), // Space between back button & title
      
                                /// **Title**
                                Text(
                                  "Design your room\nusing AI",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
      
                    /// **Lamp Image Positioned Above Everything Else**
                    Positioned(
                      top: 0, // Moves the lamp to the top of the screen
                      right: 6, // Aligns to the right
                      child: Image.asset(
                        'assets/PIC1.png',
                        width: 150, // Adjust size as needed
                        height: 150, // Adjust size as needed
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
      
                /// **Room Image Selection**
                _buildContainer(
                  _buildCard(
                    "Room Image",
                    "Upload an image of your space",
                    'assets/Image.png',
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 190,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Icon(Icons.add_a_photo, size: 45, color: Colors.grey[700]),
                        ),
                      ),
                    ),
                  ),
                ),
      
                /// **Room Type Selection**
                _buildContainer(
                  _buildCard(
                    "Room Type",
                    "What type of room is in your image?",
                    'assets/interior-design.png',
                    DropdownButtonFormField(
                      items: ["Living Room", "Bedroom", "Dining Room"]
                          .map((e) => DropdownMenuItem(child: Text(e), value: e))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                           _selectedRoomType = value as String?;
                        });
                      },
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                ),
      
                /// **Room Style Selection**
                _buildContainer(
                  _buildCard(
                    "Room Style",
                    "Choose your preferred style",
                    'assets/staging.png',
                    Wrap(
                      spacing: 2,
                      children: roomStyles.map((style) {
                        bool isSelected = selectedStyle == style;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedStyle = style;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.brown[700] : Colors.brown[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                style,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
      
                /// **Room Dimensions Input**
                _buildContainer(
                  _buildCard(
                    "Room Dimensions",
                    "Insert your room dimensions",
                    'assets/plans.png',
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _widthController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Width",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _lengthController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Length",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      
                SizedBox(height: 20),
      
                /// **Generate Button**
                Center(
                  child: SizedBox(
                    width: double.infinity, // Makes button full-width
                    child: ElevatedButton(
                      onPressed: () {
                        print("Generating AI Design...");
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.brown[700]!; // Dark brown when pressed
                            }
                            return Colors.brown[300]!; // Light brown by default
                          },
                        ),
                        foregroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.white; // White text when pressed
                            }
                            return Colors.black; // Black text by default
                          },
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 15),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Rounded corners
                          ),
                        ),
                      ),
                      child: Text(
                        "Generate",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
      
                SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// **Reusable Container with Styling**
  Widget _buildContainer(Widget child) {
    return Container(
      padding: EdgeInsets.all(19),
      margin: EdgeInsets.only(top: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }

  /// **Reusable Card Widget**
  Widget _buildCard(String title, String subtitle, String assetPath, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(assetPath, width: 50, height: 50),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        child,
      ],
    );
  }
}


