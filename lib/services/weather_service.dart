import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiUrl;
  WeatherService(this.apiUrl);

  Future<Map<String, dynamic>> getWeatherData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Hava durumu verileri yüklenemedi');
    }
  }
}