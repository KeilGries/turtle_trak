// ignore_for_file: prefer_const_constructors, unused_import

import "package:flutter/material.dart";
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:turtle_trak/presentation/custom_icons_icons.dart';

import 'pages/home_page.dart';
import 'pages/growth_page.dart';
import 'pages/climate_page.dart';
import 'pages/settings_page.dart';

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
  final screens = [HomePage(), ClimatePage(), GrowthPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('TurtleTrak'),
          backgroundColor: Color.fromARGB(220, 27, 59, 0),
        ),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(220, 27, 59, 0),
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
              label: 'Climate',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.ruler),
              label: 'Growth',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            )
          ],
        ));
  }
}
