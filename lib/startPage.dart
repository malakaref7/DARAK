// ignore_for_file: prefer_const_constructors

import 'package:darak_app/signup_login.dart';
import 'package:flutter/material.dart';
import 'package:darak_app/onboardingscreen.dart';

class Startpage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
         // background image
         SizedBox.expand(
          child: Image.asset(
            'assets\\start_screen.jpeg',
            fit: BoxFit.cover,
          ),
          ),
        
          // logo image, made like this to be able to create the shadow effect
          // duplicating the image and decreasing the opacity of the image underneath
          Container(
            alignment: Alignment(0, -0.9),
            width: 400,
            height: 350,
            child: Stack(
              children: [
                Positioned(
                  top: 2.5,
                  child: Image.asset(
                    'assets\\darak_logo.png',
                    width: 350,
                    height: 300,
                    color: const Color.fromARGB(8, 0, 0, 0).withOpacity(0.2), // Creates a shadow effect
                  ),
                ),
            
                Image.asset(
                  'assets\\darak_logo.png',
                  width: 350,
                  height: 300,
                ),
              ],
            ),
          ),


          // Get started button
          GestureDetector(
            onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      return SignupLogin();
                      })
                  );
              },
              child: Container(
              alignment: Alignment(0, 0.95), 
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Color(0xFFB6ABA4),
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5

                      ),
                      )),
                ),
              ),
            ),
          ),
        

          // back arrow
          Container(
            alignment: Alignment(-0.88, -0.88),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      return OnBoardingScreen();
                      })
                  );
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 25,
                color: Colors.black,
                
                      ),
            ),
          ),
        ],
      ),
    );
  }
}