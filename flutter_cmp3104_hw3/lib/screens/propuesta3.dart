import 'package:flutter/material.dart';

class Propuesta3 extends StatefulWidget {
  @override
  _Propuesta3State createState() => _Propuesta3State();
}

class _Propuesta3State extends State<Propuesta3> {
  String nombreIngresado = "";
  final TextEditingController controlador = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mi Aplicacion")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mi Aplicacion",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: controlador,
              decoration: InputDecoration(hintText: "Ingresa tu nombre"),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    nombreIngresado = controlador.text;
                  });
                },
                child: Text("Dame Click"),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(nombreIngresado, style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            nombreIngresado.isNotEmpty ? "Hola: $nombreIngresado" : "",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
