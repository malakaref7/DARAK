// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:darak_app/onboardingscreen.dart';
import 'package:darak_app/startPage.dart';
import 'package:darak_app/SignUp_Login/SignUpScreen.dart';
import 'package:darak_app/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  User? user = FirebaseAuth.instance.currentUser;
  runApp(MyApp(isLoggedIn: user != null));
}

class MyApp extends StatelessWidget {

  final bool isLoggedIn;
  MyApp({required this.isLoggedIn});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn ? '/home' : '/',
      routes: {
        '/': (context) => OnBoardingScreen(),
        '/start': (context) => Startpage(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => MyHomePage(),
      },
    );
  }
}

