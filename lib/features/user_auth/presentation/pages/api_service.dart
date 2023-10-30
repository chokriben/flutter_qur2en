import 'dart:convert';
import 'package:http/http.dart' as http;

class IslamicCalendarApiService {
  final String baseUrl = 'http://api.aladhan.com/v1/';

  Future<Map<String, dynamic>> getIslamicCalendarInfo(String date) async {
    final response = await http.get(Uri.parse('$baseUrl/gToH/$date'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load Islamic calendar data');
    }
  }
}
