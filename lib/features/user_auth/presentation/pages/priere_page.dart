import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PrayerTimeService {
  Future<Map<String, dynamic>> getPrayerTimes(String city, DateTime date) async {
    try {
      final formattedDate = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

      final apiUrl = "https://api.aladhan.com/v1/timingsByCity?city=$city&country=Tunisia&date=$formattedDate&method=2";

      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Impossible de récupérer les heures de prière. Code de statut : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Impossible de récupérer les heures de prière. Erreur : $e');
    }
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PrayerTimeScreen(),
    );
  }
}

class PrayerTimeScreen extends StatefulWidget {
  @override
  _PrayerTimeScreenState createState() => _PrayerTimeScreenState();
}

class _PrayerTimeScreenState extends State<PrayerTimeScreen> {
  final PrayerTimeService prayerTimeService = PrayerTimeService();
  TextEditingController cityController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Map<String, String> prayerTimes = {};

  fetchPrayerTimes() async {
    final data = await prayerTimeService.getPrayerTimes(cityController.text, selectedDate);
    setState(() {
      prayerTimes = Map<String, String>.from(data['data']['timings']);
    });
  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heures de prière'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Entrez une ville et une date :'),
            TextFormField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'Ville'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Date : '),
                TextButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          selectedDate = value;
                        });
                      }
                    });
                  },
                  child: Text(
                    "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}",
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: fetchPrayerTimes,
              child: Text("Obtenir les heures de prière"),
            ),
            if (prayerTimes.isNotEmpty)
              Column(
                children: [
                  Text('Heures de prière pour ${cityController.text} le ${selectedDate.toLocal()} :'),
                  DataTable(
                    columns: [
                      DataColumn(label: Text('Prière')),
                      DataColumn(label: Text('Heure')),
                    ],
                    rows: prayerTimes.entries.map((entry) {
                      return DataRow(
                        cells: [
                          DataCell(Text(entry.key)),
                          DataCell(Text(entry.value)),
                        ],
                      );
                    }).toList(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Ajoutez la navigation vers l'écran de la boussole Qibla ici.
                    },
                    child: Text("Boussole Qibla"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
