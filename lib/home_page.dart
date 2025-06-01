// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:darak_app/features/features.dart';

import 'package:darak_app/utilities/Utilities.dart';
import 'package:darak_app/generative/GenAI.dart';
import 'package:darak_app/AR/aug.dart';
import 'package:darak_app/explore/ExploreFurniture.dart';
import 'package:darak_app/profile.dart';


class  MyHomePage extends StatefulWidget {
  const MyHomePage ({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  late Timer _timer;
  final List<String> _imagePaths = [
    'assets/home1.jpg',
    'assets/home2.jpg',
    'assets/home3.jpg',
    'assets/home4.jpg',
    'assets/home5.jpg',
    'assets/home6.jpg',
    'assets/home7.jpg',
    'assets/home8.jpg',
    'assets/home9.jpg',
    'assets/home10.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _selectedIndex = (_selectedIndex + 1) % _imagePaths.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 4500),
            transitionBuilder: (
            Widget child, Animation<double> animation
            ) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: Container(
              key: ValueKey<String>(_imagePaths[_selectedIndex]),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(_imagePaths[_selectedIndex]),
                        fit: BoxFit.cover,
                    ),
                  ),
            ),
    ),
              SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: Column(
                        children: [
                          // Welcoming User
                          Align(
                            alignment: Alignment(-1, 1),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ProfilePage();
                                      })
                                  );
                              },
                                  child: Icon(
                                    Icons.person_2_sharp,
                                    size: 25,
                                    color: Colors.black,
                                    
                                          ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: 
                            [
                              user == null ?
                              Text(
                                'Welcome',
                                style: GoogleFonts.antonio(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 21,
                                  ),
                                ),
                              )
                                : StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return CircularProgressIndicator();
                                    }

                                    //  Get the user data from Firestore.
                                    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                                    String firstName = 
                                      "${data['firstName'] ?? ''}";

                              return Text(
                                'Welcome $firstName!',
                                style: GoogleFonts.antonio(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                              }
                                )
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "Let's turn your vision into a cozy reality",
                            style: GoogleFonts.antonio(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: SingleChildScrollView(
                                clipBehavior: Clip.none,
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ObjectGesturesWidget()));
                                      },
                                      child: AppFeatures(
                                        featureIcon: 'assets/Aug.svg',
                                        featureName: 'Augmented Reality',
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>GenAI()));
                                      },
                                      child: AppFeatures(
                                        featureIcon: 'assets/Gen.svg',
                                        featureName: 'Generative AI',
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Utilities()));
                                      },
                                      child: AppFeatures(
                                        featureIcon: 'assets/UTILITIES.svg',
                                        featureName: 'Utilities',
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FurnitureScreen()));
                                      },
                                      child: AppFeatures(
                                        featureIcon: 'assets/EX.svg',
                                        featureName: 'Explore Designs',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                          ),
                          ],
          ),
    );
  }

}

