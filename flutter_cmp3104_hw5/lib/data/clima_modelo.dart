class EstadoClima {
  final String ciudad;
  final double temperatura;
  final double viento;
  final int humedad;
  final int nubosidad;
  final String description;
  final bool estaCargando;
  final String? error;
  final List<String> favoritos;

  EstadoClima({
    this.ciudad = '',
    this.temperatura = 0,
    this.viento = 0,
    this.humedad = 0,
    this.nubosidad = 0,
    this.description = '',
    this.estaCargando = false,
    this.error,
    this.favoritos = const [],
  });

  EstadoClima copiarCon({
    String? ciudad,
    double? temperatura,
    double? viento,
    int? humedad,
    int? nubosidad,
    String? description,
    bool? estaCargando,
    String? error,
    List<String>? favoritos,
  }) {
    return EstadoClima(
      ciudad: ciudad ?? this.ciudad,
      temperatura: temperatura ?? this.temperatura,
      viento: viento ?? this.viento,
      humedad: humedad ?? this.humedad,
      nubosidad: nubosidad ?? this.nubosidad,
      description: description ?? this.description,
      estaCargando: estaCargando ?? this.estaCargando,
      error: error,
      favoritos: favoritos ?? this.favoritos,
    );
  }
}
