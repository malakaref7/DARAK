// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class UtilitiesScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
          child: Image.asset(
            'assets\\utilities.jpg',
            fit: BoxFit.cover,
          ),
        ),

        Container(
          alignment: Alignment(0, -0.7),
          child: Container(
            //color: Colors.green, 
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      blurRadius: 25, // Higher value = softer edges
                      spreadRadius: 10, // Expands the shadow outward
                    ),
                  ],
            ),
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Home Utilities",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, letterSpacing: 1.5 ),
                    ),

                  SizedBox(height: 7),

                  Text(
                    "Handymen and all home services",
                    textAlign: TextAlign.center,
                    style:TextStyle(fontSize: 24) ,)
                ],
              ),
            ),
          ),
          
        )

        ],
      ),
    );
  }
}