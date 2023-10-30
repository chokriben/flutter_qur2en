import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherApp(),
    );
  }
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final String openWeatherMapApiKey = '5b208bf7b008197d54a98d152302087b';
  String city = '';
  Map<String, dynamic> weatherData = {};

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchWeatherData() async {
    final openWeatherMapUrl = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$openWeatherMapApiKey";

    final response = await http.get(Uri.parse(openWeatherMapUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        weatherData = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horaires du Soleil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  city = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Entrez la ville',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                fetchWeatherData();
              },
              child: Text('Obtenir les horaires du soleil'),
            ),
            if (weatherData.isNotEmpty)
              WeatherDataTable(weatherData: weatherData),
          ],
        ),
      ),
    );
  }
}

class WeatherDataTable extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  WeatherDataTable({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          children: [
            TableCell(
              child: Container(
                color: Colors.blue,
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Lever du soleil',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            TableCell(
              child: Container(
                color: Colors.blue,
                padding: EdgeInsets.all(8.0),
                child: Text(
                  DateTime.fromMillisecondsSinceEpoch(weatherData['sys']['sunrise'] * 1000).toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Container(
                color: Colors.green,
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Coucher du soleil',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            TableCell(
              child: Container(
                color: Colors.green,
                padding: EdgeInsets.all(8.0),
                child: Text(
                  DateTime.fromMillisecondsSinceEpoch(weatherData['sys']['sunset'] * 1000).toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
