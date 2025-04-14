import 'package:flutter_4_bloc_cubit_clima/data/clima_modelo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/clima_repositorio.dart';

class CubitClima extends Cubit<EstadoClima> {
  final ClimaRepositorio repository;

  CubitClima(this.repository) : super(EstadoClima()) {
    cargarFavoritos(); // Carga favoritos al iniciar el cubit
  }

  Future<void> obtenerClima(String ciudad) async {
    emit(state.copiarCon(
      estaCargando: true,
      ciudad: ciudad,
      error: null,
    ));

    try {
      final clima = await repository.getWeather(ciudad);
      emit(state.copiarCon(
        ciudad: ciudad,
        temperatura: clima['temperatura'],
        viento: clima['viento'],
        humedad: clima['humedad'],
        nubosidad: clima['nubosidad'],
        description: clima['description'],
        estaCargando: false,
      ));
    } catch (e) {
      emit(state.copiarCon(
        error: e.toString(),
        estaCargando: false,
      ));
    }
  }

  Future<void> agregarFavorito(String ciudad) async {
    // final prefs = await SharedPreferences.getInstance();
    final listaActual = List<String>.from(state.favoritos);
    if (!listaActual.contains(ciudad)) {
      listaActual.add(ciudad);
      // await prefs.setStringList('favoritos', listaActual);
      emit(state.copiarCon(favoritos: listaActual));
    }
  }

  Future<void> eliminarFavorito(String ciudad) async {
    // final prefs = await SharedPreferences.getInstance();
    final listaActual = List<String>.from(state.favoritos);
    listaActual.remove(ciudad);
    // await prefs.setStringList('favoritos', listaActual);
    emit(state.copiarCon(favoritos: listaActual));
  }

  Future<void> cargarFavoritos() async {
    // final prefs = await SharedPreferences.getInstance();
    // final favoritos = prefs.getStringList('favoritos') ?? [];
    // emit(state.copiarCon(favoritos: favoritos));
  }
}
