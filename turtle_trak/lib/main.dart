// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(TurtleTrak());

class TurtleTrak extends StatelessWidget {
  const TurtleTrak({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final screens = [
    HomePage(),
    Center(
      child: Image(
          image: AssetImage('images/mock_climate_page.png'),
          width: 400.0,
          height: 800.0,
          fit: BoxFit.fill),
    ),
    Center(
      child: Image(
        image: AssetImage('images/mock_growth_chart.png'),
        width: 400.0,
        height: 800.0,
        fit: BoxFit.fill,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: Text('TurtleTrak')),
          backgroundColor: Color.fromARGB(255, 0, 126, 0),
        ),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 0, 126, 0),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          showUnselectedLabels: false,
          iconSize: 27,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
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
        ));
  }
}

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
            effects: [
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
                children: [
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

class ClimatePage extends StatelessWidget {
  const ClimatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class GrowthPage extends StatelessWidget {
  const GrowthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
