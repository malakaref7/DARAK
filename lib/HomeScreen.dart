import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the currently logged-in user.
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color(0xFF8D7E73),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: Center(
        child: user == null
            ? Text(
          'Welcome!',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        )
            : StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            // Get the user data from Firestore.
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            String firstName =
                "${data['firstName'] ?? ''}";
            return Text(
              'Welcome $firstName!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
    );
  }
}

