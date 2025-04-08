import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:darak_home/features/features.dart';

import 'package:darak_home/utilities/Utilities.dart';
import 'package:darak_home/generative/GenAI.dart';
import 'package:darak_home/AR/AR.dart';
import 'package:darak_home/explore/ExploreFurniture.dart';


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
                            child: Icon(
                              Icons.person_rounded,
                              color: Colors.black,
                              size: 27,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Welcome',
                                style: GoogleFonts.kalnia(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 21,
                                  ),
                                ),
                                ),
                              SizedBox(width: 8,),
                              Text(
                                'Amany!',
                                style: GoogleFonts.kalnia(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "Let's turn your vision into a cozy reality",
                            style: GoogleFonts.kayPhoDu(
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
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen()));
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

