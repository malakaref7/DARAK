// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:darak_app/onBoardingScreens/ar_screen.dart';
import 'package:darak_app/onBoardingScreens/genAI_screen.dart';
import 'package:darak_app/onBoardingScreens/utilities_screen.dart';
import 'package:darak_app/startPage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget{
  const OnBoardingScreen({super.key});
  
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}


  class _OnBoardingScreenState extends State<OnBoardingScreen> {

    //controller
    PageController _controller = PageController();

    bool onLastPage = false;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  onLastPage = (index == 2);
                });
              },
              children: [
                ArScreen(),
                GenAIScreen(),
                UtilitiesScreen(),
              ],
            ),

            Container(
              alignment: Alignment(0, 0.85),
              child: SmoothPageIndicator(
                controller: _controller, 
                count: 3,
                effect: ExpandingDotsEffect(
                  spacing:  8.0,    
                  radius:  5.0,    
                  dotWidth:  50.0,    
                  dotHeight:  5.0,    
                  strokeWidth:  1.5,    
                  dotColor:  Colors.white,    
                  activeDotColor:  Colors.black 
                ),
                )
            ),

            onLastPage 
            ? GestureDetector(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      return Startpage();
                      })
                  );
              } ,
              child: Container(
                alignment: Alignment(0.8, 0.95),
                child: const Text(
                  "Done",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                  ),
                  ),
            )

            : GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      return Startpage();
                      })
                  );
              } ,
              child: Container(
                alignment: Alignment(0.8, 0.95),
                child: const Text(
                  "skip",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                  ),
                  ),
            )
          ],
        )
      );
    }

  }
