import 'package:flutter/material.dart';

class Propuesta2 extends StatefulWidget {
  @override
  _Propuesta2State createState() => _Propuesta2State();
}

class _Propuesta2State extends State<Propuesta2> {
  String fechaHora = "";

  @override
  void initState() {
    super.initState();
    actualizarFecha();
  }

  void actualizarFecha() {
    setState(() {
      fechaHora = DateTime.now().toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi Prop 2"),
        actions: [
          IconButton(
            // ⬅ Add Back Button Here
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // ⬅ Navigate Back to Landing Page
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 50)),
            Text("Hola Drawer", style: TextStyle(fontSize: 20)),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                actualizarFecha();
              },
              child: Text("Cerrar"),
            ),
          ],
        ),
      ),
      body: Center(child: Text(fechaHora, style: TextStyle(fontSize: 18))),
    );
  }
}
