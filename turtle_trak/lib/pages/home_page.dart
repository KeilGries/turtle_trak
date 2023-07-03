// ignore_for_file: prefer_const_constructors, unused_import

import "package:flutter/material.dart";
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:turtle_trak/presentation/custom_icons_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage('images/TurtleTrak.jpeg'),
            width: 400.0,
            height: 800.0,
            fit: BoxFit.fill,
          ),
          Animate(
            effects: const [
              FadeEffect(duration: Duration(milliseconds: 2400)),
              // ScaleEffect(duration: Duration(milliseconds: 900)),
            ],
            child: Positioned(
              top: 0,
              bottom: 110,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Turtle',
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 250, 248, 248),
                    ),
                  ),
                  Text(
                    'Trak',
                    style: TextStyle(
                      fontSize: 50,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 0, 126, 0),
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
