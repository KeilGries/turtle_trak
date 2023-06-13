// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(TurtleTrak());

class TurtleTrak extends StatelessWidget {
  const TurtleTrak({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('TurtleTrak')),
        backgroundColor: Color.fromARGB(255, 0, 126, 0),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thermostat),
            label: 'Enclosure Climate',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.ruler),
            label: 'Growth',
          ),
        ],
      ),
      body: Image(
        image: AssetImage('images/TurtleTrak.jpeg'),
        width: 400.0,
        height: 800.0,
        fit: BoxFit.fill,
      ),
    );
  }
}

class GrowthScreen extends StatelessWidget {
  const GrowthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class ClimateScreen extends StatelessWidget {
  const ClimateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar());
  }
}
