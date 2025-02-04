import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          // Background Section
          Container(
            height: deviceHeight * 0.25, // Adjust height for background
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
                    SizedBox(width: 8),
                    Text(
                      'Contact Us',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Contact Form Section
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20), // Rounded corners at the top
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -4), // Subtle shadow above
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Leave a Message Field
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: messageController,
                          hintText: 'Leave us a Message',
                          prefixIcon: Icons.message_outlined,
                        ),
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          // Add send message logic here
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Message sent!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.send,
                          color: Color(0xFF8D7E73),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),

                  // Email Card
                  _buildContactCard(
                    icon: Icons.email_outlined,
                    title: 'Email Us',
                    subtitle: 'AppName@gmail.com',
                    backgroundColor: Color(0xFFEDE0D4), // Light brown shade
                    onTap: () {
                      // Add email action
                    },
                  ),
                  SizedBox(height: 20),

                  // Call Us Card
                  _buildContactCard(
                    icon: Icons.phone_outlined,
                    title: 'Call Us',
                    subtitle: '+20 1234567897',
                    backgroundColor: Color(0xFFEDE0D4), // Light brown shade
                    onTap: () {
                      // Add call action
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build TextField
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: Colors.brown),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.brown.shade200),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Helper method to build Contact Cards
  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.brown.shade50, // Apply custom background color
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, color: Color(0xFF8D7E73), size: 28),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown.shade600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.brown.shade300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
