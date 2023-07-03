// ignore_for_file: prefer_const_constructors, unused_import

import "package:flutter/material.dart";
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/line_chart_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Animate(
          effects: const [
          ScaleEffect(duration: Duration(milliseconds: 1000))
            ],
          child: Center(
            child: Image(
              image: AssetImage('images/HUH.png'),
              width: 400.0,
              height: 800.0,
              fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}