import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConfigureProfileScreen extends StatefulWidget {
  @override
  _ConfigureProfileScreenState createState() => _ConfigureProfileScreenState();
}

class _ConfigureProfileScreenState extends State<ConfigureProfileScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      final data = doc.data() as Map<String, dynamic>?;

      if (data != null) {
        firstNameController.text = data['firstName'] ?? '';
        lastNameController.text = data['lastName'] ?? '';
        userNameController.text = data['userName'] ?? '';
        cityController.text = data['city'] ?? '';
        areaController.text = data['area'] ?? '';
        addressController.text = data['address'] ?? '';
      }
    }
  }

  Future<void> _saveProfile() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection("users").doc(user.uid).update({
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'userName': userNameController.text.trim(),
        'city': cityController.text.trim(),
        'area': areaController.text.trim(),
        'address': addressController.text.trim(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile configured successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    cityController.dispose();
    areaController.dispose();
    addressController.dispose();
    super.dispose();
  }

  // Helper method to build TextFields.
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade600),
        filled: true,
        fillColor: Colors.grey.shade200,
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          // Background Section.
          Container(
            height: deviceHeight * 0.25,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('waves.png'),
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
                      'Configure Profile',
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

          // Form Section.
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // First and Last Name Row.
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: firstNameController,
                            hintText: 'First Name',
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: _buildTextField(
                            controller: lastNameController,
                            hintText: 'Last Name',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),

                    // User Name Field.
                    _buildTextField(
                      controller: userNameController,
                      hintText: 'User Name',
                    ),
                    SizedBox(height: 40),

                    // City and Area Row.
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: cityController,
                            hintText: 'City',
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: _buildTextField(
                            controller: areaController,
                            hintText: 'Area',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),

                    // Address Field.
                    _buildTextField(
                      controller: addressController,
                      hintText: 'Address',
                    ),
                    SizedBox(height: 180),

                    // Save Button.
                    Center(
                      child: SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: _saveProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF8D7E73),
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
}
