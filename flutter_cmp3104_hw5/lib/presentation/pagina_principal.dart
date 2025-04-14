import 'package:flutter/material.dart';
import 'package:flutter_4_bloc_cubit_clima/data/clima_modelo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logica/clima_cubit.dart';
import 'pagina_detalles.dart';

class PaginaPresentacion extends StatelessWidget {
  final TextEditingController ciudadControlador = TextEditingController();

  PaginaPresentacion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App de Clima')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: ciudadControlador,
              decoration: InputDecoration(labelText: 'Ingresa la Ciudad'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final ciudad = ciudadControlador.text.trim();
                if (ciudad.isNotEmpty) {
                  await context.read<CubitClima>().obtenerClima(ciudad);
                  if (context.read<CubitClima>().state.error == null) {
                    context.read<CubitClima>().agregarFavorito(ciudad);
                  }
                }
              },
              child: Text('Click para Consultar Clima'),
            ),
            SizedBox(height: 20),
            BlocBuilder<CubitClima, EstadoClima>(
              builder: (context, state) {
                if (state.estaCargando) {
                  return CircularProgressIndicator();
                } else if (state.error != null) {
                  return Text('Error: ${state.error}');
                } else if (state.ciudad.isNotEmpty) {
                  return Column(
                    children: [
                      Text('Ciudad: ${state.ciudad}',
                          style: TextStyle(fontSize: 20)),
                      Text('Temperatura: ${state.temperatura}°C',
                          style: TextStyle(fontSize: 20)),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage()),
                          );
                        },
                        child: Text('Mirar Detalles'),
                      ),
                    ],
                  );
                } else {
                  return Text('Ingresa una ciudad para consultar el clima');
                }
              },
            ),
            SizedBox(height: 20),
            Text('Ciudades Favoritas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<CubitClima, EstadoClima>(
                builder: (context, state) {
                  if (state.favoritos.isEmpty) {
                    return Text("No hay ciudades favoritas.");
                  } else {
                    return ListView.builder(
                      itemCount: state.favoritos.length,
                      itemBuilder: (context, index) {
                        final ciudad = state.favoritos[index];
                        return ListTile(
                          title: Text(ciudad),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              context
                                  .read<CubitClima>()
                                  .eliminarFavorito(ciudad);
                            },
                          ),
                          onTap: () {
                            context.read<CubitClima>().obtenerClima(ciudad);
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
