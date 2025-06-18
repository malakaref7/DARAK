// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:darak_app/onboardingscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:darak_app/home_page.dart';
import 'package:page_transition/page_transition.dart';



class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  
  void _navigateAfterAnimation(Duration duration ) async {
    await Future.delayed(duration);

    final user = FirebaseAuth.instance.currentUser;
    if (!mounted) return;

    Navigator.pushReplacement(
    context,
    PageTransition(
      type: PageTransitionType.fade,
      duration: Duration(milliseconds: 350),
      curve: Curves.fastOutSlowIn,
      child: user != null ? MyHomePage() : OnBoardingScreen(),
    ),
);

}



@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDE6E1),
      body: Lottie.asset(
          'assets/darak_splash.json',
          width: 450,
          height: 450,
          repeat: false,
          onLoaded: (composition) {
            _navigateAfterAnimation(composition.duration);
          },
        ),
      );
  }
}

