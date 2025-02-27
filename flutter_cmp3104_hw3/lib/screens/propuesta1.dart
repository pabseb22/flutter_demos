import 'package:flutter/material.dart';

class Propuesta1 extends StatefulWidget {
  @override
  _Propuesta1State createState() => _Propuesta1State();
}

class _Propuesta1State extends State<Propuesta1> {
  String textoIngresado = "";
  final TextEditingController controlador = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Propuesta 1")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Propuesta 1",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Subtitulo: Prog Apps",
                style: TextStyle(fontSize: 18),
              ),
            ),

            SizedBox(height: 20),
            Center(child: Text(textoIngresado, style: TextStyle(fontSize: 18))),
            SizedBox(height: 20),
            TextField(
              controller: controlador,
              decoration: InputDecoration(hintText: "Escribe aquí"),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    textoIngresado = controlador.text;
                  });
                },
                child: Text("Click Me"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
