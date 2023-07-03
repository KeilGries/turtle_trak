// ignore_for_file: prefer_const_constructors, unused_import

import "package:flutter/material.dart";
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import '../widgets/line_chart_widget.dart';

Future<Climate> fetchClimate() async {
  await dotenv.load();

  final authResponse = await http.post(
    Uri.parse('https://api.sensorpush.com/api/v1/oauth/authorize'),
    body: {
      "email": dotenv.env['API_USERNAME'],
      "password": dotenv.env['API_PASSWORD']
    },
  );
  final authResponseJson = jsonDecode(authResponse.body);
  final authorization = authResponseJson['authorization'];
  print(authorization);

  final oAuthResponse = await http.post(
    Uri.parse('https://api.sensorpush.com/api/v1/oauth/accesstoken'),
    body: {"authorization": authorization},
  );
  final oAuthResponseJson = jsonDecode(oAuthResponse.body);
  final oAuth = oAuthResponseJson['accesstoken'];
  print(oAuth);

  final sampleResponse = await http.post(
    Uri.parse('https://api.sensorpush.com/api/v1/samples'),
    body: {
      "limit": "10",
    },
    headers: {
      "Authorization": oAuth,
    },
  );
  print(sampleResponse.statusCode);
  final sampleResponseJson = jsonDecode(sampleResponse.body);
  final sample = sampleResponseJson;
  print(sample);

  return Climate.fromJson(sampleResponseJson);
}

class Climate {
  final double temp;
  final double humidity;
  final String obsTime;

  const Climate({
    required this.temp,
    required this.humidity,
    required this.obsTime,
  });
  factory Climate.fromJson(Map<String, dynamic> json) {
    final sensorData = json['sensors']['16839523.2869329425359625035'];

    List<Map<String, dynamic>> entriesList = [];

    List<dynamic> entries = sensorData as List<dynamic>;

    for (int i = 0; i < entries.length; i++) {
      String time = entries[i]['observed'];
      var dateValue =
          new DateFormat("yyyy-MM-ddTHH:mm:ssZ").parseUTC(time).toLocal();
      String formattedDate = DateFormat.yMd().add_jm().format(dateValue);

      Map<String, dynamic> entry = {
        'observed': formattedDate,
        'gateways': entries[i]['gateways'],
        'temperature': entries[i]['temperature'],
        'humidity': entries[i]['humidity'],
      };

      entriesList.add(entry);
    }

    print(entriesList);
    print('--------------------------');
    print(entriesList[0]['observed']);

    final latestSample = sensorData.isNotEmpty ? sensorData[0] : null;

    return Climate(
      temp: latestSample?['temperature']?.toDouble(),
      humidity: latestSample?['humidity']?.toDouble(),
      obsTime: entriesList[0]['observed'],
    );
  }
}

class ClimatePage extends StatefulWidget {
  const ClimatePage({super.key});

  @override
  State<ClimatePage> createState() => _ClimatePageState();
}

class _ClimatePageState extends State<ClimatePage> {
  late Future<Climate> futureClimate;

  @override
  void initState() {
    super.initState();
    futureClimate = fetchClimate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/climate_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: FutureBuilder<Climate>(
              future: futureClimate,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final climate = snapshot.data!;
                  return Animate(
                    effects: const [
                      FadeEffect(duration: Duration(milliseconds: 500)),
                    ],
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Container(
                        padding: EdgeInsets.only(top: 8),
                        height: 170,
                        width: 275,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 212, 207, 200),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(209, 27, 59, 0),
                                spreadRadius: 3),
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3))
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                'Current Conditions',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  // fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                  'Observation Time: ${climate.obsTime}',
                                  textAlign: TextAlign.left),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text('Temperature: ${climate.temp} °F',
                                  textAlign: TextAlign.left),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text('Humidity: ${climate.humidity}%',
                                  textAlign: TextAlign.left),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    backgroundColor:
                                        Color.fromARGB(255, 89, 110, 129)),
                                icon: Icon(Icons.refresh_outlined),
                                label: Text('Refresh'),
                                onPressed: () {
                                  setState(() {
                                    futureClimate = fetchClimate();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Padding(
                  padding: const EdgeInsets.all(110.0),
                  child: const CircularProgressIndicator(),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    fixedSize: Size(250, 60),
                    elevation: 13,
                    backgroundColor: Color.fromARGB(255, 89, 110, 129)),
                icon: Icon(
                  Icons.bar_chart_rounded,
                  size: 35,
                ),
                label: Text('Display Graph', style: TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LineChartWidget()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
