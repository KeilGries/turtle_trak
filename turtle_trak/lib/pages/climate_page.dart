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
      body: Center(
        child: FutureBuilder<Climate>(
          future: futureClimate,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final climate = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Current Conditions',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  Text('Observation Time: ${climate.obsTime}',
                      textAlign: TextAlign.left),
                  Text('Temperature: ${climate.temp}',
                      textAlign: TextAlign.left),
                  Text('Humidity: ${climate.humidity}',
                      textAlign: TextAlign.left),
                  ElevatedButton(
                    child: const Text('Refresh'),
                    onPressed: () {
                      setState(() {
                        futureClimate = fetchClimate();
                      });
                      print(climate.obsTime);
                      print(climate.temp);
                      print(climate.humidity);
                    },
                  )
                ],
              );
            }
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
