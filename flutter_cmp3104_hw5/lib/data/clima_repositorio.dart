import 'package:flutter_4_bloc_cubit_clima/data/clima_dataProvider.dart';

class ClimaRepositorio {
  final ClimaServicio api = ClimaServicio();

  Future<Map<String, dynamic>> getWeather(String ciudad) async {
    try {
      return await api.obtenerClima(ciudad);
    } catch (e) {
      throw Exception("Error en el repositorio: ${e.toString()}");
    }
  }
}
