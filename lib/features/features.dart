import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AppFeatures extends StatelessWidget {
  final String featureIcon;
  final String featureName;

  const AppFeatures({super.key,
    required this.featureIcon,
    required this.featureName,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:  [ ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
          child: Container(
            height: 185,
            width: 120,
            decoration: BoxDecoration(
              color: Color(0xCC8D7E73),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Color(0xCC8D7E73),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x25000000),
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  blurStyle: BlurStyle.outer
                )
              ]
            ),
            padding: EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               SizedBox(
                 height: 97,
                 width: 95,
                 child: SvgPicture.asset(
                   featureIcon,
                   fit: BoxFit.contain,
                 ),
               ),
                SizedBox(height: 10,),
                  Text(
                    featureName,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cantoraOne(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
              ]
            ),
          ),
        ),
      ),
    ],
    );
  }
}
