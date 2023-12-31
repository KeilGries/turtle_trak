// ignore_for_file: prefer_const_constructors, unused_import

import "package:flutter/material.dart";
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GrowthPage extends StatelessWidget {
  const GrowthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: Image(
        image: AssetImage('images/mock_growth_chart.png'),
        width: 400.0,
        height: 800.0,
        fit: BoxFit.fill,
      ),
    ),
    );
  }
}