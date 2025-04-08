import 'package:flutter/material.dart';
import 'package:darak_home/home_page.dart';

class ProviderDetailsPage extends StatelessWidget {
  final Map<String, dynamic> provider;

  const ProviderDetailsPage({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    // Check if provider is a Lighting or Painting expert
    bool isLightingService = provider["specialization"].toLowerCase().contains("lighting");

    return Scaffold(
      backgroundColor: Colors.grey[200], // Background color for contrast
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: Image.asset(
                    isLightingService
                        ? 'assets/light_provider.jpg' // Background for lighting
                        : 'assets/paint_provider.jpg', // Background for painting
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Back Button
                Positioned(
                  top: 40, // Adjust for status bar
                  left: 16,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                ),
                // Home Button (Image)
                Positioned(
                  top: 40, // Adjust for status bar
                  right: 16,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    },
                    child: Image.asset(
                      "assets/Darak.png", // Home icon image
                      width: 36, // Adjust size as needed
                      height: 36,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(provider["image"]),
                        radius: 30,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(provider["name"],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(provider["specialization"],
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text("\$${provider["price"]}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    isLightingService
                        ? "Specializes in designing and installing customized lighting solutions."
                        : "Expert in providing professional painting and refinishing services.",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  SizedBox(height: 20),
                  Text("Services:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: isLightingService
                          ? [
                        Text("• System Design and Installation"),
                        Text("• Inspection and Maintenance"),
                        Text("• Consulting and Compliance Studies"),
                        Text("• Damage Analysis and Repair"),
                      ]
                          : [
                        Text("• Interior & Exterior Painting"),
                        Text("• Cabinet Refinishing & Staining"),
                        Text("• Decorative & Faux Painting"),
                        Text("• Commercial & Residential Projects"),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(color: Colors.black26),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.black),
                          SizedBox(width: 5),
                          Text("0123456789", style: TextStyle(fontSize: 16, color: Colors.black)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.email, color: Colors.black),
                          SizedBox(width: 5),
                          Text("provider@example.com", style: TextStyle(fontSize: 16, color: Colors.black)),
                        ],
                      ),
                    ],
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



