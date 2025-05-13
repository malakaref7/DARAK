import 'package:flutter/material.dart';
import 'package:darak_app/home_page.dart';
import 'package:darak_app/SignUp_Login/LoginScreen.dart';
import 'package:darak_app/SignUp_Login/SignUpScreen.dart';
import 'package:darak_app/profile.dart';
import 'package:darak_app/profileScreens/ChangePasswordScreen.dart';
import 'package:darak_app/profileScreens/ConfigureProfileScreen.dart';
import 'package:darak_app/profileScreens/ContactUsScreen.dart';
import 'package:darak_app/profileScreens/SavedInsposScreen.dart';


class SignupLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/signup': (context) =>SignUpScreen(),
        '/home': (context) => MyHomePage(),
        '/profile': (context) => ProfilePage(),
        '/change-password': (context) => ChangePasswordScreen(),
        '/configure-profile': (context) => ConfigureProfileScreen(),
        '/saved-inspos': (context) => SavedInsposScreen(),
        '/contact-us': (context) => ContactUsScreen(),
      },
    );
  }
}