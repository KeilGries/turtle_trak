import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartWidget extends StatelessWidget {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text('TurtleTrak'),
        backgroundColor: Color.fromARGB(220, 27, 59, 0),
      ),
      body: LineChart(
        LineChartData(minX: 0, maxX: 23, minY: 0, maxY: 120, lineBarsData: [
          LineChartBarData(spots: [
            FlSpot(0, 3),
            FlSpot(2, 33),
            FlSpot(5, 66),
            FlSpot(8, 79),
            FlSpot(10, 115),
            FlSpot(13, 34),
            FlSpot(16, 78),
            FlSpot(19, 40),
            FlSpot(21, 70),
            FlSpot(23, 59),
          ])
        ]),
      ),
    );
  }
}
