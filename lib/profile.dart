import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ChangePasswordScreen.dart';
import 'ConfigureProfileScreen.dart';
import 'ContactUsScreen.dart';
import 'SavedInsposScreen.dart';

class ProfilePage extends StatelessWidget {
  // Logout function: signs out the user and navigates to the login screen.
  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/'); // Adjust route if needed.
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(child: Text("No user is logged in.")),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background section.
          Container(
            height: 420,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('waves.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Top Section with Back Arrow and Title.
          Positioned(
            top: MediaQuery.of(context).padding.top + 15,
            left: 16,
            right: 16,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // This SizedBox ensures proper spacing; you may adjust or remove it.
                SizedBox(width: 48),
              ],
            ),
          ),

          // Horizontal Line below Title.
          Positioned(
            top: MediaQuery.of(context).padding.top + 60,
            left: 16,
            right: 16,
            child: Container(
              height: 2,
              color: Colors.white,
            ),
          ),

          // Profile details and user data.
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());

              Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
              String fullName =
                  "${data['firstName'] ?? ''} ${data['lastName'] ?? ''}";

              return Column(
                children: [
                  SizedBox(height: 100),
                  Center(
                    child: Column(
                      children: [
                        // Circular profile icon.
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),
                          child: Icon(
                            Icons.person_outline,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          fullName,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        TextButton(
                          onPressed: () {
                            // Add functionality to edit profile picture.
                          },
                          child: Text(
                            'Edit Profile Picture',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          // List section styled as a centered box.
          Positioned(
            top: 350,
            left: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: SizedBox(
                height: 465,
                child: Column(
                  children: [
                    ListTile(
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      leading: Icon(Icons.settings,
                          color: Color(0xFF8D7E73), size: 26),
                      title: Text(
                        'Configure Profile',
                        style: TextStyle(
                          color: Color(0xFF8D7E73),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Color(0xFF8D7E73), size: 20),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConfigureProfileScreen(),
                          ),
                        );
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[350]),
                    ListTile(
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      leading: Icon(Icons.lock,
                          color: Color(0xFF8D7E73), size: 26),
                      title: Text(
                        'Change Password',
                        style: TextStyle(
                          color: Color(0xFF8D7E73),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Color(0xFF8D7E73), size: 20),
                      onTap: () {
                        // Navigate to ChangePasswordScreen.
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangePasswordScreen(),
                          ),
                        );
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[350]),
                    ListTile(
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      leading: Icon(Icons.favorite,
                          color: Color(0xFF8D7E73), size: 26),
                      title: Text(
                        'View Saved Inspo',
                        style: TextStyle(
                          color: Color(0xFF8D7E73),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Color(0xFF8D7E73), size: 20),
                      onTap: () {
                        // Navigate to SavedInsposScreen.
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SavedInsposScreen(),
                          ),
                        );
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[350]),
                    ListTile(
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      leading: Icon(Icons.contact_phone,
                          color: Color(0xFF8D7E73), size: 26),
                      title: Text(
                        'Contact Us',
                        style: TextStyle(
                          color: Color(0xFF8D7E73),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Color(0xFF8D7E73), size: 20),
                      onTap: () {
                        // Navigate to ContactUsScreen.
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactUsScreen(),
                          ),
                        );
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[400]),
                    ListTile(
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      leading: Icon(Icons.directions_walk,
                          color: Color(0xFF8D7E73), size: 26),
                      title: Text(
                        'Walkthrough',
                        style: TextStyle(
                          color: Color(0xFF8D7E73),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Color(0xFF8D7E73), size: 20),
                      onTap: () {
                        // Add functionality.
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[350]),
                    ListTile(
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      leading: Icon(Icons.logout,
                          color: Colors.red, size: 26),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Color(0xFF8D7E73), size: 20),
                      onTap: () {
                        _logout(context); // Call the logout function
                      },
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
