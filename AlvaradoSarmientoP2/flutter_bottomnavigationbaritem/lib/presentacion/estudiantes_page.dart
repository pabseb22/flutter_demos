import 'package:flutter/material.dart';
import 'package:flutter_bottomnavigationbaritem/data/modelo/usuario_modelo.dart';
import 'package:flutter_bottomnavigationbaritem/dominio/repositorio/usuario_repositorio.dart';

class EstudiantesPage extends StatefulWidget {
  const EstudiantesPage({super.key});
  @override
  State<EstudiantesPage> createState() => _EstudiantesPageState();
}

class _EstudiantesPageState extends State<EstudiantesPage> {
  List<UsuarioModel> usuarios = [];
  //TextEditors para tomar los datos
  final nombreController = TextEditingController();
  final emailController = TextEditingController();
  //Se instancia de la clase UsuarioRepositorio para usar los metodos eliminar e insertar
  final UsuarioRepositorio usuarioRepositorio = UsuarioRepositorio();
  // metodo initState, se ejecuta a penas comienza la app
  @override
  void initState() {
    super.initState();
    _cargarUsuarios();
  }

  //Funcion para actualizar usuarios  (se utiliza en los botones eliminar y insertar)
  Future<void> _cargarUsuarios() async {
    final data = await usuarioRepositorio.obtenerUsuarios();
    setState(() {
      usuarios = data; // Actualiza la lista de usuarios
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuarios - SQlite')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // id = 0 para que SQLite lo autogenere (AUTOINCREMENT), si se coloca otro numero no se puede colocar mas usuarios
                usuarioRepositorio.insertarUsuario(UsuarioModel(
                    id: 0,
                    nombre: nombreController.text,
                    email: emailController.text));
                nombreController.clear();
                emailController.clear();
                _cargarUsuarios();
              },
              child: const Text('Agregar Usuario'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: usuarios.length,
                itemBuilder: (context, index) {
                  final usuario = usuarios[index];
                  return Card(
                    child: ListTile(
                      title: Text(usuario.nombre),
                      subtitle: Text(usuario.email),
                      trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            usuarioRepositorio.eliminarUsuario(usuario.id);
                            _cargarUsuarios();
                          }),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
