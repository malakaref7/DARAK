import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'profile.dart';
import 'ChangePasswordScreen.dart';
import 'ConfigureProfileScreen.dart';
import 'SavedInsposScreen.dart';
import 'ContactUsScreen.dart';
import 'LoginScreen.dart';
import 'SignUpScreen.dart';
import 'HomeScreen.dart'; // Import HomeScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfilePage(),
        '/change-password': (context) => ChangePasswordScreen(),
        '/configure-profile': (context) => ConfigureProfileScreen(),
        '/saved-inspos': (context) => SavedInsposScreen(),
        '/contact-us': (context) => ContactUsScreen(),
      },
    );
  }
}
