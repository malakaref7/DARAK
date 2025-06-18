import 'package:flutter/material.dart';
import 'ProviderDetailsPage.dart';
import 'package:darak_app/home_page.dart';

class ServiceProvidersPage extends StatelessWidget {
  final String serviceName;

  // Lighting Service Providers
  final List<Map<String, dynamic>> lightingProviders = [
    {
      "name": "Maria Lopez",
      "specialization": "Lighting Installation",
      "price": 50,
      "image": "assets/provider1.jpg",
    },
    {
      "name": "John Doe",
      "specialization": "LED Lighting Expert",
      "price": 40,
      "image": "assets/provider2.jpg",
    },
    {
      "name": "Emma Smith",
      "specialization": "Lighting Design",
      "price": 30,
      "image": "assets/provider3.jpg",
    },
    {
      "name": "William Johnson",
      "specialization": "Smart Lighting Setup",
      "price": 45,
      "image": "assets/provider4.jpg",
    },
    {
      "name": "Sophia Davis",
      "specialization": "Lighting Repair",
      "price": 60,
      "image": "assets/provider5.jpg",
    },
    {
      "name": "Michael Brown",
      "specialization": "Electrical Lighting Installation",
      "price": 55,
      "image": "assets/provider6.jpg",
    },
    {
      "name": "Olivia Wilson",
      "specialization": "Outdoor Lighting Expert",
      "price": 50,
      "image": "assets/provider7.jpg",
    },
  ];

  // Painting Service Providers (Same names & images, different specializations)
  final List<Map<String, dynamic>> paintingProviders = [
    {
      "name": "Maria Lopez",
      "specialization": "Interior Painting",
      "price": 50,
      "image": "assets/provider1.jpg",
    },
    {
      "name": "John Doe",
      "specialization": "Exterior Painting",
      "price": 40,
      "image": "assets/provider2.jpg",
    },
    {
      "name": "Emma Smith",
      "specialization": "Wallpaper Installation",
      "price": 30,
      "image": "assets/provider3.jpg",
    },
    {
      "name": "William Johnson",
      "specialization": "Decorative Painting",
      "price": 45,
      "image": "assets/provider4.jpg",
    },
    {
      "name": "Sophia Davis",
      "specialization": "Cabinet Refinishing",
      "price": 60,
      "image": "assets/provider5.jpg",
    },
    {
      "name": "Michael Brown",
      "specialization": "Commercial Painting",
      "price": 55,
      "image": "assets/provider6.jpg",
    },
    {
      "name": "Olivia Wilson",
      "specialization": "Fence & Deck Painting",
      "price": 50,
      "image": "assets/provider7.jpg",
    },
  ];

  ServiceProvidersPage({super.key, required this.serviceName});

  @override
  Widget build(BuildContext context) {
    // Select the correct provider list based on service name
    final List<Map<String, dynamic>> selectedProviders =
    serviceName.toLowerCase() == "painting" ? paintingProviders : lightingProviders;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: [
            // Background image
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF6F3F1),
              ),
            ),
            // Top section with back button, service name, and home button
            Positioned(
              top: 10,
              left: 15,
              right: 15,
              child: Row(
                children: [
                  // Back Button
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 10), // Space between the arrow and text
                  Expanded(
                    child: Text(
                      serviceName,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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
                      "assets/Darak.png", // Home icon image
                      width: 36, // Adjust size
                      height: 36,
                    ),
                  ),
                ],
              ),
            ),
            // List of providers
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: ListView.builder(
                itemCount: selectedProviders.length,
                itemBuilder: (context, index) {
                  var provider = selectedProviders[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProviderDetailsPage(provider: provider),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.brown[100],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(provider["image"]),
                            radius: 30,
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider["name"],
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                Text(provider["specialization"]),
                              ],
                            ),
                          ),
                          Text("\$${provider["price"]}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}






