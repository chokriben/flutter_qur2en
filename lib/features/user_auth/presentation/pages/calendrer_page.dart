import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IslamicCalendarScreen(),
    );
  }
}

class IslamicCalendarScreen extends StatefulWidget {
  @override
  _IslamicCalendarScreenState createState() => _IslamicCalendarScreenState();
}

class _IslamicCalendarScreenState extends State<IslamicCalendarScreen> {
  String hijriDate = "No data";
  String ramadanDate = "No data";
  String aidDate = "No data";
  DateTime selectedDate = DateTime.now();
  bool isLoading = false;

  void getIslamicCalendarData(DateTime date) async {
    try {
      setState(() {
        isLoading = true;
      });

      final formattedDate =
          "${date.year}-${date.month}-${date.day}";
      final response = await http.get(
          Uri.parse("http://api.aladhan.com/v1/gToH/$formattedDate"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          hijriDate = data['data']['hijri']['date'] ?? "No data";
          ramadanDate = data['data']['hijri']['events']['ramadan'] ?? "No data";
          aidDate = data['data']['hijri']['events']['eid'] ?? "No data";
          isLoading = false;
        });
      } else {
        print('Error fetching Islamic calendar data. Status code: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching Islamic calendar data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        getIslamicCalendarData(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Islamic Calendar'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Hijri Date: ${isLoading ? "Loading..." : hijriDate}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Ramadan Date: ${isLoading ? "Loading..." : ramadanDate}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Aïd Date: ${isLoading ? "Loading..." : aidDate}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select Date'),
            ),
          ],
        ),
      ),
    );
  }
}
