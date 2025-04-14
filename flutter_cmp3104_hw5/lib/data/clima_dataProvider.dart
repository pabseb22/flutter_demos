import 'dart:convert';
import 'package:http/http.dart' as http;

class ClimaServicio {
  static const String apiKey = 'f6f35b8330070b3c91b94ae01ca4c5fd';
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> obtenerClima(String city) async {
    final response = await http.get(
      Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return {
        'temperatura': data['main']['temp'].toDouble(),
        'viento': data['wind']['speed'].toDouble(),
        'humedad': data['main']['humidity'].toInt(),
        'nubosidad': data['clouds']['all'].toInt(),
        'description': data['weather'][0]['description']
      };
    } else {
      throw Exception('Error al obtener el clima: ${response.reasonPhrase}');
    }
  }
}
